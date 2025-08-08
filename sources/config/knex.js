import knex from 'knex';

const knexInstance = knex({
    client: 'pg',
    connection: {
        host: 'localhost',
        port: '5432',
        user: 'postgres',
        password: 'sic parvis magna',
        database: 'standard_model_api'
    },
    pool: {min: 2, max: 10}

});

export default knexInstance;