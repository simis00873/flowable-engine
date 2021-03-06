update ACT_GE_PROPERTY set VALUE_ = '6.6.0.0' where NAME_ = 'common.schema.version';

alter table ACT_RU_ENTITYLINK add ROOT_SCOPE_ID_ NVARCHAR2(255);
alter table ACT_RU_ENTITYLINK add ROOT_SCOPE_TYPE_ NVARCHAR2(255);
create index ACT_IDX_ENT_LNK_ROOT_SCOPE on ACT_RU_ENTITYLINK(ROOT_SCOPE_ID_, ROOT_SCOPE_TYPE_, LINK_TYPE_);

alter table ACT_HI_ENTITYLINK add ROOT_SCOPE_ID_ NVARCHAR2(255);
alter table ACT_HI_ENTITYLINK add ROOT_SCOPE_TYPE_ NVARCHAR2(255);
create index ACT_IDX_HI_ENT_LNK_ROOT_SCOPE on ACT_HI_ENTITYLINK(ROOT_SCOPE_ID_, ROOT_SCOPE_TYPE_, LINK_TYPE_);

alter table ACT_RU_ENTITYLINK add SUB_SCOPE_ID_ NVARCHAR2(255);
alter table ACT_RU_ENTITYLINK add PARENT_ELEMENT_ID_ NVARCHAR2(255);

alter table ACT_HI_ENTITYLINK add SUB_SCOPE_ID_ NVARCHAR2(255);
alter table ACT_HI_ENTITYLINK add PARENT_ELEMENT_ID_ NVARCHAR2(255);

update ACT_GE_PROPERTY set VALUE_ = '6.6.0.0' where NAME_ = 'entitylink.schema.version';

update ACT_GE_PROPERTY set VALUE_ = '6.6.0.0' where NAME_ = 'identitylink.schema.version';

alter table ACT_RU_JOB add CATEGORY_ NVARCHAR2(255);

alter table ACT_RU_TIMER_JOB add CATEGORY_ NVARCHAR2(255);

alter table ACT_RU_SUSPENDED_JOB add CATEGORY_ NVARCHAR2(255);

alter table ACT_RU_DEADLETTER_JOB add CATEGORY_ NVARCHAR2(255);

create table ACT_RU_EXTERNAL_JOB (
    ID_ NVARCHAR2(64) NOT NULL,
    REV_ INTEGER,
    CATEGORY_ NVARCHAR2(255),
    TYPE_ NVARCHAR2(255) NOT NULL,
    LOCK_EXP_TIME_ TIMESTAMP(6),
    LOCK_OWNER_ NVARCHAR2(255),
    EXCLUSIVE_ NUMBER(1,0) CHECK (EXCLUSIVE_ IN (1,0)),
    EXECUTION_ID_ NVARCHAR2(64),
    PROCESS_INSTANCE_ID_ NVARCHAR2(64),
    PROC_DEF_ID_ NVARCHAR2(64),
    ELEMENT_ID_ NVARCHAR2(255),
    ELEMENT_NAME_ NVARCHAR2(255),
    SCOPE_ID_ NVARCHAR2(255),
    SUB_SCOPE_ID_ NVARCHAR2(255),
    SCOPE_TYPE_ NVARCHAR2(255),
    SCOPE_DEFINITION_ID_ NVARCHAR2(255),
    RETRIES_ INTEGER,
    EXCEPTION_STACK_ID_ NVARCHAR2(64),
    EXCEPTION_MSG_ NVARCHAR2(2000),
    DUEDATE_ TIMESTAMP(6),
    REPEAT_ NVARCHAR2(255),
    HANDLER_TYPE_ NVARCHAR2(255),
    HANDLER_CFG_ NVARCHAR2(2000),
    CUSTOM_VALUES_ID_ NVARCHAR2(64),
    CREATE_TIME_ TIMESTAMP(6),
    TENANT_ID_ NVARCHAR2(255) DEFAULT '',
    primary key (ID_)
);

create index ACT_IDX_EJOB_EXCEPTION on ACT_RU_EXTERNAL_JOB(EXCEPTION_STACK_ID_);
create index ACT_IDX_EJOB_CUSTOM_VAL_ID on ACT_RU_EXTERNAL_JOB(CUSTOM_VALUES_ID_);

alter table ACT_RU_EXTERNAL_JOB
    add constraint ACT_FK_EJOB_EXCEPTION
    foreign key (EXCEPTION_STACK_ID_)
    references ACT_GE_BYTEARRAY (ID_);

alter table ACT_RU_EXTERNAL_JOB
    add constraint ACT_FK_EJOB_CUSTOM_VAL
    foreign key (CUSTOM_VALUES_ID_)
    references ACT_GE_BYTEARRAY (ID_);

create index ACT_IDX_EJOB_SCOPE on ACT_RU_EXTERNAL_JOB(SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_EJOB_SUB_SCOPE on ACT_RU_EXTERNAL_JOB(SUB_SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_EJOB_SCOPE_DEF on ACT_RU_EXTERNAL_JOB(SCOPE_DEFINITION_ID_, SCOPE_TYPE_);

alter table ACT_RU_JOB add CORRELATION_ID_ NVARCHAR2(255);
alter table ACT_RU_TIMER_JOB add CORRELATION_ID_ NVARCHAR2(255);
alter table ACT_RU_SUSPENDED_JOB add CORRELATION_ID_ NVARCHAR2(255);
alter table ACT_RU_DEADLETTER_JOB add CORRELATION_ID_ NVARCHAR2(255);
alter table ACT_RU_EXTERNAL_JOB add CORRELATION_ID_ NVARCHAR2(255);

create index ACT_IDX_JOB_CORRELATION_ID on ACT_RU_JOB(CORRELATION_ID_);
create index ACT_IDX_TJOB_CORRELATION_ID on ACT_RU_TIMER_JOB(CORRELATION_ID_);
create index ACT_IDX_SJOB_CORRELATION_ID on ACT_RU_SUSPENDED_JOB(CORRELATION_ID_);
create index ACT_IDX_DJOB_CORRELATION_ID on ACT_RU_DEADLETTER_JOB(CORRELATION_ID_);
create index ACT_IDX_EJOB_CORRELATION_ID on ACT_RU_EXTERNAL_JOB(CORRELATION_ID_);

update ACT_GE_PROPERTY set VALUE_ = '6.6.0.0' where NAME_ = 'job.schema.version';

update ACT_GE_PROPERTY set VALUE_ = '6.6.0.0' where NAME_ = 'batch.schema.version';

update ACT_GE_PROPERTY set VALUE_ = '6.6.0.0' where NAME_ = 'task.schema.version';

update ACT_GE_PROPERTY set VALUE_ = '6.6.0.0' where NAME_ = 'variable.schema.version';

update ACT_GE_PROPERTY set VALUE_ = '6.6.0.0' where NAME_ = 'eventsubscription.schema.version';

alter table ACT_RU_EXECUTION add LOCK_OWNER_ NVARCHAR2(255);
alter table ACT_RU_EXECUTION add EXTERNAL_WORKER_JOB_COUNT_ INTEGER;

alter table ACT_RU_ACTINST add TRANSACTION_ORDER_ INTEGER;

alter table ACT_HI_ACTINST add TRANSACTION_ORDER_ INTEGER;

update ACT_GE_PROPERTY set VALUE_ = '6.6.0.0' where NAME_ = 'schema.version';
update ACT_ID_PROPERTY set VALUE_ = '6.6.0.0' where NAME_ = 'schema.version';


UPDATE ACT_APP_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.10.1 (192.168.10.1)', LOCKGRANTED = to_timestamp('2020-10-06 14:12:19.675', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 1 AND LOCKED = 0;

UPDATE ACT_APP_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;



UPDATE ACT_CMMN_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.10.1 (192.168.10.1)', LOCKGRANTED = to_timestamp('2020-10-06 14:12:20.971', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 1 AND LOCKED = 0;

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LOCK_OWNER_ VARCHAR2(255);

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', SYSTIMESTAMP, 11, '7:e77f0eb21b221f823d6a0e198144cefc', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', 'EXECUTED', NULL, NULL, '3.5.3', '1993541264');

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_UNAVAILABLE_TIME_ TIMESTAMP(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD LAST_UNAVAILABLE_TIME_ TIMESTAMP(3);

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', SYSTIMESTAMP, 12, '7:c5ddabeb0c9fb8db6371c249097d78a3', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '3.5.3', '1993541264');

UPDATE ACT_CMMN_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;



UPDATE FLW_EV_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.10.1 (192.168.10.1)', LOCKGRANTED = to_timestamp('2020-10-06 14:12:21.916', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 1 AND LOCKED = 0;

UPDATE FLW_EV_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;



UPDATE ACT_DMN_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.10.1 (192.168.10.1)', LOCKGRANTED = to_timestamp('2020-10-06 14:12:22.607', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 1 AND LOCKED = 0;

DROP INDEX ACT_IDX_DEC_TBL_UNIQ;

ALTER TABLE ACT_DMN_DECISION_TABLE RENAME TO ACT_DMN_DECISION;

CREATE UNIQUE INDEX ACT_IDX_DMN_DEC_UNIQ ON ACT_DMN_DECISION(KEY_, VERSION_, TENANT_ID_);

INSERT INTO ACT_DMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('7', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', SYSTIMESTAMP, 6, '7:4b6469565b1b00b428ffca7eab1ef253', 'dropIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE; renameTable newTableName=ACT_DMN_DECISION, oldTableName=ACT_DMN_DECISION_TABLE; createIndex indexName=ACT_IDX_DMN_DEC_UNIQ, tableName=ACT_DMN_DECISION', '', 'EXECUTED', NULL, NULL, '3.5.3', '1993542905');

ALTER TABLE ACT_DMN_DECISION ADD DECISION_TYPE_ VARCHAR2(255);

INSERT INTO ACT_DMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('8', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', SYSTIMESTAMP, 7, '7:f83b7b3228be2c4bbb554d6de45307d7', 'addColumn tableName=ACT_DMN_DECISION', '', 'EXECUTED', NULL, NULL, '3.5.3', '1993542905');

UPDATE ACT_DMN_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;



UPDATE ACT_FO_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.10.1 (192.168.10.1)', LOCKGRANTED = to_timestamp('2020-10-06 14:12:23.602', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 1 AND LOCKED = 0;

UPDATE ACT_FO_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;



UPDATE ACT_CO_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.10.1 (192.168.10.1)', LOCKGRANTED = to_timestamp('2020-10-06 14:12:24.326', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 1 AND LOCKED = 0;

UPDATE ACT_CO_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;

