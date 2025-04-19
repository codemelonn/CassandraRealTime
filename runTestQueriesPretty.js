const fs = require('fs');
const path = require('path');
const mysql = require('./mysql_backend/mysql');
const Table = require('cli-table3');

const QUERY_FILE = path.join(__dirname, 'sql', 'testQueries.sql');

function formatDate(val) {
    if (!(val instanceof Date)) return val;
    const yyyy = val.getFullYear();
    const mm = String(val.getMonth() + 1).padStart(2, '0');
    const dd = String(val.getDate()).padStart(2, '0');
    const hh = String(val.getHours()).padStart(2, '0');
    const mi = String(val.getMinutes()).padStart(2, '0');
    const ss = String(val.getSeconds()).padStart(2, '0');
    return `${yyyy}-${mm}-${dd} ${hh}:${mi}:${ss}`;
}

async function runPrettyQuery(query) {
    const connection = await mysql.getConnection();
    try {
        const [rows, fields] = await connection.execute(query);
        if (rows.length === 0) {
            console.log('No results.\n');
            return;
        }

        const table = new Table({
            head: fields.map(field => field.name),
            wordWrap: true
        });

        for (let row of rows) {
            const formattedRow = fields.map(field => {
                const val = row[field.name];
                if (val instanceof Date) return formatDate(val);
                if (typeof val === 'number' && !Number.isInteger(val)) {
                    return parseFloat(val.toFixed(2));
                }
                return val;
            });
            table.push(formattedRow);
        }

        console.log(table.toString() + '\n');
    } catch (err) {
        console.error(`❌ Error with query: ${query.trim()}\n${err.message}\n`);
    } finally {
        connection.release();
    }
}

async function runAllQueries() {
    const file = fs.readFileSync(QUERY_FILE, 'utf-8');
    const queries = file.split(';').map(q => q.trim()).filter(q => q.length > 0);
    for (let query of queries) {
        if (/^use\s+/i.test(query)) continue; // skip USE statements
        await runPrettyQuery(query + ';');
    }
}

runAllQueries();
