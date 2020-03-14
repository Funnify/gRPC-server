-- create database easytrack_db;

create table if not exists et_users
(
    id                       serial primary key,
    id_token                 varchar default null,
    name                     varchar,
    email                    varchar unique,
    tag                      varchar default NULL,
    last_sync_timestamp      bigint,
    last_heartbeat_timestamp bigint
);

create table if not exists et_campaigns
(
    id              serial primary key,
    creator_id      integer references et_users (id),
    name            varchar,
    notes           varchar,
    config_json     varchar,
    start_timestamp bigint,
    end_timestamp   bigint
);

alter table et_users
    add column campaign_id integer references et_campaigns (id) default null;

create table if not exists et_campaign_to_user_maps
(
    user_id        integer references et_users (id),
    campaign_id    integer references et_campaigns (id),
    join_timestamp bigint,
    unique (user_id, campaign_id)
);

create table if not exists et_data_sources
(
    id         serial primary key,
    creator_id integer references et_users (id) on delete cascade,
    name       varchar unique,
    icon_name  varchar
);

create table if not exists et_direct_messages
(
    src_user_id integer references et_users (id) on delete cascade,
    trg_user_id integer references et_users (id) on delete cascade,
    timestamp   bigint,
    subject     varchar,
    content     varchar,
    read        boolean default false
);

create table if not exists et_notifications
(
    trg_user_id integer references et_users (id) on delete cascade,
    timestamp   bigint,
    subject     varchar,
    content     varchar,
    read        boolean default false
);
