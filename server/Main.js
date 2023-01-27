const express = require('express');
const app = express();
const path = require('path')
const fs = require('fs');
const {createPool} = require('mysql2')
const cors = require('cors')

app.use(cors())

const SERVER_LATENCY = 1000;

const pool = createPool({
        host: "localhost",
        user: "root",
        password: "userRoot"
    }
)

const getFunctionMenuSql = () => {
    try {
        const data = fs.readFileSync('./functionMenu.sql', {encoding: 'utf8'});
        console.error(data);
        return data;
    } catch (err) {
        console.error("ERROR");
        console.error(err);
        return "";
    }
}

const getFunctionMenu = () => {
    return new Promise((resolve) => {
        pool.query(getFunctionMenuSql(), (err, res) => {
            resolve(res);
        });
    });
}

const getTable = (tableTame) => {
    return new Promise((resolve) => {
        pool.query(" select * from sql_uj_3sem." + tableTame, (err, res) => {
            resolve(res);
        });
    });
}

app.use(express.static(path.join(__dirname, 'build')));

app.get('/', function (req, res) {
    res.sendFile(path.join(__dirname, 'build', 'index.html'))
});

app.get('/files/README', async function (req, res) {
    await new Promise(resolve => setTimeout(resolve, SERVER_LATENCY));
    res.sendFile(path.join(__dirname, 'public', 'README.md'))
});

app.get('/api/functionMenu', async function (req, res) {
    await new Promise(resolve => setTimeout(resolve, SERVER_LATENCY));

    const result = await getFunctionMenu();
    console.log(result)
    const resultJson = JSON.stringify(result);
    res.end(
        resultJson
    )
});


app.get('/api/select/', async function (req, res) {
    await new Promise(resolve => setTimeout(resolve, SERVER_LATENCY));

    let databaseName = req.query.databaseName;

    const result = await getTable(databaseName);
    console.log(result)
    const resultJson = JSON.stringify(result);
    res.end(
        resultJson
    )
});

app.listen(3000);
