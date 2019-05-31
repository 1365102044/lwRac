//
//  LWFmdb.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/11/28.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "LWFmdb.h"
#import "FMDatabaseAdditions.h" // 导入头文件
#import <objc/runtime.h>

@interface LWFmdb  ()
@property (nonatomic, strong) FMDatabase * db;
/**
 数据模型对象
 */
@property (nonatomic, strong) NSObject * ModelObjc;

@end

@implementation LWFmdb

+ (instancetype)share
{
    static LWFmdb *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LWFmdb alloc] init];
        [instance createDB];
    });
    return instance;
}

/**
 创建数据库
 
 @return 返回成功YES；失败NO
 */
- (BOOL)createDB
{
    NSString *filePath = [self createFile];
    NSString *dbpath = [NSString stringWithFormat:@"%@/haoyuDB.db",filePath];
    NSLog(@"\n***********数据库地址：%@",dbpath);
    self.db = [FMDatabase databaseWithPath:dbpath];
    if ([self.db open]) {
        return YES;
    }else{
        return NO;
    }
}

/**
 创建文件
 */
- (NSString *)createFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    NSString *filepath = [documentDirectory stringByAppendingPathComponent:@"haoyuData"];
    BOOL isExist = [fileManager fileExistsAtPath:filepath];
    if (!isExist) {
        BOOL sucess = [fileManager createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:NULL];
        if(!sucess){
            NSLog(@"创建文件失败");
            return nil;
        }
    }
    return filepath;
}

/**
 创建table 根据表类型
 
 @param tableType 表类型
 @return 返回 成功YES； 失败NO
 */
- (BOOL)openTableWithDBTableType:(LWBDTableType)tableType
{
    if ([self.db open]) {
        NSString *sql = [self getCreateBDTableSqlWithTableType:tableType];
        if (!sql){
            NSLog(@"****创建tableType:%ld 获取sql失败",tableType);
            return NO;
        }
        BOOL res =  [self.db executeUpdate:sql];
        if (res) {
            NSLog(@"****创建tableType:%ld 成功",(long)tableType);
            return res;
        }
    }
    NSLog(@"****创建tableType:%ld 失败",tableType);
    return NO;
}

#pragma mark ---插入数据

/**
 插入数据
 
 @param data 数据模型（模型NSArray,数据模型）
 @param tableType 表类型
 @return 返回成功(YES/NO)
 */
- (BOOL)insertDataToDBWithData:(id)data tableType:(LWBDTableType)tableType
{
    if(![_db open]) return NO;
    
    [self openTableWithDBTableType:tableType];
    
    NSString *sqls = [self getInsertSqlWithTableType:tableType data:data];
    if (!sqls) {
        return NO;
    }
    
    //检查对象的属性是否存在表中字段，不存在则新增表字段
    [self checkTableColsNameAndObjctProperties:tableType];
    
    NSLog(@"*******sqls:%@",sqls);
    NSArray *sqls_arr = [sqls componentsSeparatedByString:@";"];
    [_db beginTransaction];
    BOOL isRool = NO;
    BOOL res = NO;
    @try{
        for (NSString *sql in sqls_arr) {
            res =  [self.db executeUpdate:sql];
            if (!res) {
                isRool = YES;
                break;
            }
        }
    }@catch(NSException *e){
        isRool = YES;
        [_db rollback];
    }@finally{
        if (!isRool) {
            [_db commit];
        }
    }
    [_db close];
    return res;
}


# pragma mark ---删除
/**
 根据条件删除表中的某一条记录 删除条件：keys,values：NSArray(字符串数组，个数必须相同)/NSString,
 
 @param keys 数据库对应的keys
 @param values key对应的值
 @param tableType 表类型
 @return 返回是否成功(YES/NO)
 */
- (BOOL)deleteDataWithPropertyNames:(id)keys
                      propertyValue:(id)values
                          tableType:(LWBDTableType)tableType
{
    NSString *tableName = [self getDBTableNameWithTableType:tableType];
    if (!tableName) return NO;
    if(![_db open]) return nil;
    if ([keys class] != [values class]) return NO;
    if (!keys || !values) return NO;
    NSString *dele_sql = nil;
    if ([keys isKindOfClass:[NSArray class]] && [values isKindOfClass:[NSArray class]]) {
        NSArray *keysArr = (NSArray *)keys;
        NSArray *valuesArr = (NSArray *)values;
        __block NSString *tempSql = nil;
        __block NSString *key = nil;
        __block NSString *value = nil;
        if (keysArr.count == 0 || valuesArr.count == 0 || keysArr.count != valuesArr.count) return NO;
        [keysArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            key = [keysArr objectAtIndex:idx];
            value = [valuesArr objectAtIndex:idx];
            if (idx == 0){
                tempSql = [NSString stringWithFormat:@"%@='%@'",key,value];
            }else{
                NSString *keyvalue = [NSString stringWithFormat:@"%@ = '%@'",key,value];
                tempSql = [NSString stringWithFormat:@"%@ and %@",tempSql,keyvalue];
            }
        }];
        dele_sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",tableName,tempSql];
    }else if([keys isKindOfClass: [NSString class]] && [values isKindOfClass:[NSString class]]){
        dele_sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@=%@",tableName,keys,values];
    }
    NSLog(@"***********dele_sql:%@",dele_sql);
    if (!dele_sql) return NO;
    BOOL res = [_db executeUpdate:dele_sql];
    [_db close];
    return res;
}

/**
 根据表名删除表中所有数据
 
 @param tableType 表类型
 */
- (BOOL)deleteAllDataWithtableType:(LWBDTableType)tableType
{
    NSString *tableName = [self getDBTableNameWithTableType:tableType];
    if (!tableName) return NO;
    if(![_db open]) return NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
    BOOL res = [_db executeUpdate:sql];
    [_db close];
    return res;
}

/**
 删除表
 
 @param tableType 表类型
 @return 返回结果
 */
- (BOOL)deleteTableWithTableType:(LWBDTableType)tableType
{
    NSString *tableName = [self getDBTableNameWithTableType:tableType];
    if (!tableName) return NO;
    if(![_db open]) return NO;
    NSString *sql = [NSString stringWithFormat:@"drop table %@",tableName];
    BOOL res = [_db executeUpdate:sql];
    [_db close];
    return res;
}

#pragma mark ---查询

/**
 查询表中的所有数据
 
 @param className 数据模型类名
 @param tableType 表类型
 @return 返回查询到的数据模型对象数组NSArray/nil
 */
- (id)getDataWithObjcClassName:(NSString *)className tableType:(LWBDTableType)tableType
{
    NSArray * resArrary = [self
                           getDataWithObjcClassName:className range:NSMakeRange(0, 0) tableType:tableType];
    return resArrary;
}

/**
 查询指定行数的数据
 
 @param className 数据模型类名
 @param range 要查询的数据在表中的位置(当NSMakeRange(0, 0)，查所有数据)
 @param tableType 表类型
 @return 返回数据模型对象数组/nil
 */
- (id)getDataWithObjcClassName:(NSString *)className
                         range:(NSRange)range
                     tableType:(LWBDTableType)tableType
{
    NSMutableArray *resArrary = [[NSMutableArray alloc] init];
    Class objcClass = NSClassFromString(className);
    if (!objcClass) return nil;
    NSString *tableName = [self getDBTableNameWithTableType:tableType];
    if (!tableName) return nil;
    if(![_db open]) return nil;
    NSString *sql = [self getQuerySqlWithTableType:tableType range:range];
    FMResultSet *res = [_db executeQuery:sql];
    NSArray *propers = [self getProperties:[objcClass class]];
    if (!propers) return nil;
    while (res.next) {
        NSObject *objc = [objcClass new];
        for (NSString *pro in propers) {
            NSString *proValue = [res stringForColumn:pro];
            @try{
                [objc setValue:proValue forKey:pro];
            }@catch(NSException *e){
                NSLog(@"********查询数据，赋值失败：%@",pro);
            }
        }
        [resArrary addObject:objc];
    }
    [_db close];
    return resArrary;
}

/**
 获取查询数据的SQL
 
 @param tableType 表类型
 @param range 查询范围
 @return SQL
 */
- (NSString *)getQuerySqlWithTableType:(LWBDTableType)tableType range:(NSRange)range
{
    NSString *tableName = [self getDBTableNameWithTableType:tableType];
    if (!tableName) return nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    if (tableType == LWDBTableTypeMessge) {
        sql = [sql stringByAppendingString:@" ORDER BY ct DESC"];
        if(!(range.location == 0 && range.length == 0) ) {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY ct DESC limit %ld,%ld",tableName,range.location,range.length];
        }
    }else{
        if(!(range.location == 0 && range.length == 0) ){
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ limit %ld,%ld",tableName,range.location,range.length];
        }
    }
    return sql;
}

/**
 查询表中的数据条数
 
 @param tableType 列类型
 @return 数据条数
 */
- (NSInteger)getDatasCountWithTableType:(LWBDTableType)tableType
{
    [self.db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@",[self getDBTableNameWithTableType:tableType]];
    NSInteger count = [self.db intForQuery:sql];
    [self.db close];
    return count;
}


/**
 查询表中的所有列数
 
 @param tableType 表类型
 @return 列数
 */
- (NSInteger)getTableColsWithTableType:(LWBDTableType)tableType
{
    [self.db open];
    NSString *sql = [NSString stringWithFormat:@"select COLUMN_NAME,column_comment from INFORMATION_SCHEMA.Columns where table_name='%@' and table_schema='haoyuDB.db'",[self getDBTableNameWithTableType:tableType]];
    FMResultSet * allClos  =  [self.db executeQuery:sql];
    return allClos.columnCount;
}

/**
 为表中新增字段(为以后表的升级做准备)
 
 @param property 需要新增的字段
 @param tableType 表类型
 */
- (void)addFieldForDBTableWithProperty:(NSString *)property tableType:(LWBDTableType)tableType
{
    if (!property) return;
    NSString *tableName = [self getDBTableNameWithTableType:tableType];
    if(![self.db columnExists:property inTableWithName:tableName]){
        NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ TEXT",tableName,property];
        BOOL res = [self.db executeUpdate:sql];
        if (res) {
            NSLog(@"*********在%@表中插入了：%@字段,成功!",tableName,property);
        }else{
            NSLog(@"*********在%@表中插入了：%@字段,失败!",tableName,property);
        }
    }
}

/**
 检查对象属性和表字段，当属性个数多余表字段时，为表添加新的字段
 
 @param tableType 表类型
 */
- (void)checkTableColsNameAndObjctProperties:(LWBDTableType)tableType
{
    NSArray *properties = [self getProperties:[self.ModelObjc class]];
    //    NSInteger tableCols = [self getTableColsWithTableType:tableType];
    //    if (properties.count > tableCols) {
    //    }
    for (NSString *property in properties) {
        [self addFieldForDBTableWithProperty:property tableType:tableType];
    }
}

/**
 插入城市列表数据
 
 @param data json数据
 */
- (void)insertCityData:(id)data
{
    [self insertDataToDBWithData:data tableType:LWDBTableTypeCitys];
}

/**
 根据表类型 获取表名
 
 @param tableType 表类型
 @return 返回表明
 */
- (NSString *)getDBTableNameWithTableType:(LWBDTableType)tableType
{
//    NSString *tableHeader = nil;
    switch (tableType) {
        case LWDBTableTypeCitys:
            return @"t_citys";
        case LWDBTableTypeMessge:
            return @"t_message";
            break;
        default:
            return nil;
            break;
    }
//    NSString *phone = USERDEFAULTS_GET(USER_INFOR_PHONE);
//    if (!phone) return nil;
//    NSString *tableName = [NSString stringWithFormat:@"%@_%@",tableHeader,phone];
//    return tableName;
}

/**
 根据表类型 获取创建table_SQL
 
 @param tableType 表类型
 @return 返回创建表SQL
 */
- (NSString *)getCreateBDTableSqlWithTableType:(LWBDTableType)tableType
{
    NSArray *propers = [self getProperties:[self.ModelObjc class]];
    NSString *keyString = nil;
    for (NSString *pro in propers) {
        if (!keyString) {
            keyString = [NSString stringWithFormat:@"(%@ text",pro];
        }else{
            keyString = [NSString stringWithFormat:@"%@,%@ text",keyString,pro];
        }
    }
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@%@)",[self getDBTableNameWithTableType:tableType],keyString];
    return sql;
}

/**
 根据表类型 获取插入数据SQL
 
 @param tableType 表类型
 @param data 数据（数据模型对象或者数据模型对象数组）
 @return 返回插入SQL
 */
- (NSString *)getInsertSqlWithTableType:(LWBDTableType)tableType data:(id)data
{
    if (!data) {
        NSLog(@"*****插入的数据不能为空******");
        return nil;
    }
    NSArray *properties = nil;
    NSObject * dataObjc = nil;
    if ([data isKindOfClass:[NSArray class]]) {
        NSArray *dataArr = (NSArray *)data;
        if (dataArr.count == 0) return nil;
        dataObjc = dataArr.firstObject;
        properties = [self getProperties:[dataObjc class]];
    }else{
        dataObjc =  data;
        properties = [self getProperties:[dataObjc class]];
    }
    
    NSLog(@"*************获取的所有属性：%@*****",properties);
    
    NSString *propersString = nil;
    NSString *valuePlacaHolderString = nil;
    for (NSString *pro in properties) {
        if(!propersString){
            propersString  = pro;
            NSString *value = @"";
            @try{
                value = [dataObjc valueForKey:pro];
            }@catch(NSException *e){
                NSLog(@"******插入数据取值报错：%@",e);
            }
            valuePlacaHolderString = [NSString stringWithFormat:@"('%@'",value];
        }else{
            propersString = [NSString stringWithFormat:@"%@,%@",propersString,pro];
            NSString *value = @"";
            @try{
                value = [dataObjc valueForKey:pro];
            }@catch(NSException *e){
                NSLog(@"******插入数据取值报错：%@",e);
            }
            valuePlacaHolderString = [NSString stringWithFormat:@"%@,'%@'",valuePlacaHolderString,value];
        }
    }
    
    NSString *tableName = [self getDBTableNameWithTableType:tableType];
    if (!tableName) {
        NSLog(@"******插入数据，获取表名时失败*****");
        return  nil;
    }
    
    NSString *keysString = [NSString stringWithFormat:@"(%@)",propersString];
    NSString *insert_sql = [NSString stringWithFormat:@"INSERT INTO %@%@ VALUES %@)",tableName,keysString,valuePlacaHolderString];
    self.ModelObjc = dataObjc;
    //  检查表中是否存在该条数据
    if ([self checkDuplicationDataWithTableType:tableType objc:dataObjc]) {
        insert_sql = nil;
    }
    
    /**
     数据为数组模型，拼接剩余数据
     */
    if ([data isKindOfClass:[NSArray class]]) {
        NSArray *dataArr = (NSArray *)data;
        if(dataArr.count == 0) return nil;
        else if(dataArr.count > 1) {
            for (int i = 1; i < dataArr.count; i ++) {
                NSObject *objc = dataArr[i];
                if (![objc isMemberOfClass:[self.ModelObjc class]]) {
                    NSLog(@"***********该数组中的对象类型不相同：%@",data);
                    break;
                }
                if(![self checkDuplicationDataWithTableType:tableType objc:objc]){
                    NSString *insertsql = [NSString stringWithFormat:@"INSERT INTO %@%@ VALUES %@)",tableName,keysString,[self getInsertSqlKeysWithPropers:properties objc:objc]];
                    insert_sql = (insert_sql != nil) ? [NSString stringWithFormat:@"%@;%@",insert_sql,insertsql] : insertsql;
                }
            }
        }
    }
    NSLog(@"\n**********插入语句：%@",insert_sql);
    return insert_sql;
}

/**
 检查表中是否存在该数据
 
 @param tableType 表类型
 @param objc 数据对象
 @return 是否存在 YES 存在；NO 不存在
 */
- (BOOL)checkDuplicationDataWithTableType:(LWBDTableType)tableType objc:(NSObject *)objc
{
    NSString *field = [self getCheckDuplicationDataOfFieldWithTableType:tableType];
    
    if(!field) return NO;
    NSString *sql = nil;
    @try{
        sql = [NSString stringWithFormat:@"SELECT *FROM %@ WHERE %@ = '%@'",[self getDBTableNameWithTableType:tableType],field,[objc valueForKey:field]];
        FMResultSet *res = [self.db executeQuery:sql];
        if ([res next]) {
            return YES;
        }else{
            return NO;
        }
    }@catch(NSException *e){
        return NO;
    }
}

/**
 获取检查数据存在的依靠字段
 
 @param tableType 表类型
 @return 返回依靠查询的字段，
 */
- (NSString *)getCheckDuplicationDataOfFieldWithTableType:(LWBDTableType)tableType
{
    if (tableType == LWDBTableTypeMessge) {
        return @"customId";
    }
    return nil;
}

/**
 获取key的拼接
 
 @param propers 对象的属性数组
 @param dataObjc 数据对象
 @return 数据字符 eg:（‘jack’,'32','110')
 */
- (NSString *)getInsertSqlKeysWithPropers:(NSArray *)propers objc:(NSObject *)dataObjc
{
    NSString *valuePlacaHolderString = nil;
    for (NSString *pro in propers) {
        if(!valuePlacaHolderString){
            valuePlacaHolderString = [NSString stringWithFormat:@"('%@'",[dataObjc valueForKey:pro]];
        }else{
            valuePlacaHolderString = [NSString stringWithFormat:@"%@,'%@'",valuePlacaHolderString,[dataObjc valueForKey:pro]];
        }
    }
    return valuePlacaHolderString;
}

/**
 获取该类的所有属性
 
 @param cls 类
 @return 类的所有属性
 */
- (NSArray *)getProperties:(Class)cls
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int count = 0;
    objc_property_t * pro_t_s = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t pro_t = pro_t_s[i];
        const char *pro_n = property_getName(pro_t);
        NSString *pro_name = [NSString stringWithCString:pro_n encoding:NSUTF8StringEncoding];
        [props addObject:pro_name];
    }
    [props insertObject:@"customId" atIndex:0];
    return props.copy;
}

@end
