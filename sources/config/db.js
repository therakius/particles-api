import knexInstance from "./knex.js";

knexInstance.on('query', (query)=>{
    console.log("Connected successfully to the database")
});

export default knexInstance