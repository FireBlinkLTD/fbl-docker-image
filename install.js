const dependencies = require('./package.json').dependencies;
const exec = require('child_process').exec;

const installOne = async (name, version) => {
    return new Promise((res, rej) => {
        console.log(`--> Installing ${name}@${version}`);
        exec(`npm i -g ${name}@${version} --unsafe-perm=true`, (err) => {
            if (err) {
                return rej(err);
            }

            res();
        })
    })
}

const installAll = async() => {
    console.log('-> Installing all the dependencies globally');
    for (const name of Object.keys(dependencies)) {
        const version = dependencies[name];    
        await installOne(name, version);
    }
    console.log('<- Installation successfully completed');
}

installAll()
    .catch(err => {
        console.error(err);
        process.exit(1);
    }) 

