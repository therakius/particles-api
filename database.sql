create type fermion_type as ENUM ('quark', 'lepton');
create type fermion_generation as ENUM ('first', 'second', 'third');
create type unit_for_lifetime as ENUM ('y', 's');

create table if not exists fermions (
    id serial primary key,
    name text,
    type fermion_type,
    symbol text,
    spin double precision,
    mass_display text,
    mass_value double precision,
    mass_uncertainty double precision,
    electric_charge double precision,
    generation fermion_generation,
    baryon_number double precision,
    color_change text,
    stability text,
    lifetime_display text, 
    lifetime_value double precision,
    lifetime_unit unit_for_lifetime
);

create table if not exists bosons (
    id serial primary key,
    name text,
    symbol text,
    spin double precision,
    mass_display text,
    mass_value double precision,
    mass_uncertainty double precision,
    electric_charge double precision,
    color_change text,
    stability text,
    lifetime_display text,
    lifetime_value double precision,
    lifetime_unit unit_for_lifetime,
    primary_decay_mode text
);

create table if not exists forces (
    id serial primary key,
    name text,
    description text
);

create table if not exists  boson_forces (
    boson_id int references bosons(id),
    force_id int references forces(id),
    primary key (boson_id, force_id)
);

create table if not exists boson_fermion (
    fermion_id int references fermions(id),
    boson_id int references bosons(id),
    primary key (fermion_id, boson_id)
);

create table if not exists dacay_modes (
    id serial primary key,
    decay_width double precision, 
    min_branching_ratio double precision,
    max_branching_ratio double precision,
    role_in_standard_model text
);

create table if not exists decay_modes_bosons (
    boson_id int references bosons(id),
    decay_mode_id int references dacay_modes(id),
    primary key(boson_id, decay_mode_id)
);

create table IF NOT EXISTS users (
    id serial primary key,
    username text not null,
    email text not null,
    password text not null,
    created_on date default now()
);

create table if NOT EXISTS tokens (
    id serial primary key,
    token_hash text unique,
    user_id int references users(id)
);

alter table fermions
alter column spin set default 1/2;
