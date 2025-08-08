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
alter column spin set default 0.5;

alter table fermions
alter column baryon_number set default ;

alter table fermions 
alter column baryon_number type double precisipn
alter column electric_charge type double precision,
alter column spin type double precision;

-- inserting data
-- fermions
insert into fermions (name, type, symbol, mass_display, mass_value, mass_uncertainty, electric_charge, generation, color_change, stability, lifetime_display, lifetime_value, lifetime_unit)
values 
('Up','quark', 'u', '2.16 ± 0.07 MeV', 2.16, 0.07, 2::double precision/3, 'first', 'Yes (Red, Green, Blue)', 'Stable (in hadrons)', '> 5.27 x 10^41 (in proton)', 5.27e41, 's'),
('Down', 'quark', 'd', '4.70 ± 0.07 MeV', 4.70, 0.07, -1::double precision/3, 'first', 'Yes (Red, Green, Blues)', 'Stable (in hadrons)', '> 5.27 x 10^41 s (in proton)', 5.27e41, 's');

