import express from 'express';
import morgan from 'morgan';
import knexInstance from './sources/config/db.js';

const app = express()
const port = 3000
const db = knexInstance;
app.use(express.json())

app.get('/', async (req, res)=>{
    const  result = await db('fermions').select('*');
    console.log(result)
    res.send("API is running")
})

app.listen(port, ()=>{
    console.log("API running on port " + port)
})

