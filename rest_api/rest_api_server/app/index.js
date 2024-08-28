
const express = require('express');
var bodyParser = require('body-parser');
const querystring = require("querystring");
const app = express();
app.use(express.json());
app.use( bodyParser.json() ); 
const fs = require('fs');
const port = 8087;
const { exec } = require("child_process");
var ext=JSON.parse(fs.readFileSync(__dirname+'/ext.json','utf8'));


function callDocker(req,res,tmp,countInput,argc,query) {
    var s="";
    console.log("script/launchvm.sh "+query.lang+" data/"+tmp+" "+query.countInput);
    exec("script/launchvm.sh "+query.lang+" data/"+tmp+" "+query.countInput, (error, stdout, stderr) => {
	if (error) {
	    res.send('{"code":1006,"msg":"error trying to execute virtual machine \''
                     +error.cmd+'\' error message is \''+stderr+'\' stdout: '+stdout+'."}');
	    return;
	}
	let out=[];
	for (let i=0;i<countInput;++i) {
	    var f = 'data/'+tmp+'/out/out'+i+'.txt';
	    if (fs.existsSync(f)) {
		out[i]=fs.readFileSync(f,
				       {encoding:'utf8', flag:'r'});
	    } else {
		out[i]="";
	    }
	}
	let errcode=[];
	for (let i=0;i<countInput;++i) {
	    var f = 'data/'+tmp+'/out/errcode'+i+'.txt';
	    if (fs.existsSync(f)) {
		errcode[i]=fs.readFileSync(f,
				       {encoding:'utf8', flag:'r'});
	    } else {
		errcode[i]="1";
	    }
	}
	let err=[];
	for (let i=0;i<countInput;++i) {
	    var f = 'data/'+tmp+'/out/err'+i+'.txt';
	    if (fs.existsSync(f)) {
		err[i]=fs.readFileSync(f,
				       {encoding:'utf8', flag:'r'});
	    } else {
		err[i]="";
	    }
	}
	output='{"data":[';
	for (let i=0;i<countInput;++i) {
	    output+='{"code":'+errcode[i].replace(/\n/g, '')+',"out":"'+encodeURIComponent(out[i])+'","err":"'+encodeURIComponent(err[i])+'"}';
	    if (i+1<countInput) output+=',';
	}
	output+="]}";
	console.log(output);
	res.send(output);
    });
}

function handleRestRequest(req,res,query) {
    if (!('lang' in query)) {
        s=" The 'lang' variable should have on of the following value: ";
        s+=Object.keys(ext).join(", ")
	res.send('{"code":1002,"msg":"\'lang\' variable is expected in query string. '+s+'."}');
	return;
    }
    if (!(query.lang in ext)) {
        s=" The 'lang' variable should have on of the following value: ";
        s+=Object.keys(ext).join(", ")
	res.send('{"code":1005,"msg":"Language not supported. '+s+'."}');
	return;
    }
    if (!('countInput' in query)) {
	res.send('{"code":10022,"msg":"countInput variable expected, to give the number of different executions to perform."}');
	return;
    }
    if (isNaN(Number(query.countInput))) {
	res.send('{"code":10022,"msg":"countInput variable expected, to give the number of different executions to perform."}');
	return;
    }
    let argc=[];
    let countInput=Number(query.countInput);
    for (let i=0;i<countInput;++i) {
        if (('argc_'+i) in query) {
            let b=Number(query["argc_"+i])
            if (!isNaN(b)) {
                argc[i]=b;
            } else {
                argc[i]=0;
            }
        } else {
            argc[i]=0;
        }
	if (!(('input'+i) in query)) {
            query['input'+i]='';
	    //res.send('{"code":10022,"msg":"\'input$i\' variable expected in query string."}');
	    //return;
	}
    }
    if (!('code' in query)) {
	res.send('{"code":1003,"msg":"\'code\' variable expected in query string."}');
	return;
    }

    const tmp = Math.floor(Math.random() *10000000).toString();
    fs.mkdir('data/'+tmp, (err) => {
	if (err) {
	    console.error(err);
	    res.send('{"code":1004,"msg":"mkdir error."}');
	    return;
	}
	console.log('Directory '+tmp+' created successfully!');
	fs.mkdir('data/'+tmp+'/in', (err) => {
	    if (err) {
		console.error(err);
		res.send('{"code":1004,"msg":"mkdir /in error."}');
		return;
	    }
	    console.log('Directory '+tmp+'/in created successfully!');
	    if (!(query.lang in ext)) {
		res.send('{"code":1005,"msg":"language not supported. Here is the list: '
                         +JSON.stringify(Object.keys(ext)).replace(/"/g, '\'')+'."}');
		return;
	    }
	    const myext = ext[query.lang];
	    //querystring.unescape
	    fs.writeFileSync('data/'+tmp+'/in/prog.'+myext,query.code);
	    for (let i=0;i<countInput;++i) {
		fs.writeFileSync('data/'+tmp+"/in/input"+i+".txt", query["input"+i]);
		fs.writeFileSync('data/'+tmp+"/in/argc_"+i+".txt", String(argc[i]));
                for (let j=0;j<argc[i];++j) {
                    let fname='data/'+tmp+"/in/argv_"+i+"_"+j+".txt";
                    if ("argv_"+i+"_"+j in query) {
                        fs.writeFileSync(fname, query["argv_"+i+"_"+j]);
                    } else {
                        fs.writeFileSync(fname, "");
                    }
                }
	    }
	    callDocker(req,res,tmp,countInput,argc,query);
	}); 
    });

}
/*
app.get('/',(req,res) => {
    if (!('query' in req)) {
	res.send('{"code":1000,"msg":"query string expected."}');
	return;
    }
    handleRestRequest(req,res,req.query);
    })
    */
app.get('/api',(req,res) => {
    if (!('query' in req)) {
	res.send('{"code":1000,"msg":"query string expected."}');
	return;
    }
    handleRestRequest(req,res,req.query);
})
/*
app.post('/',(req,res) => {
    res.send('reading post request.\n'+JSON.stringify(Object.keys(req.body)));
    handleRestRequest(req,req,req.body);
})
*/
app.post('/api',(req,res) => {
    res.send('reading post request.\n'+JSON.stringify(Object.keys(req.body)));
    handleRestRequest(req,req,req.body);
})

app.listen(port,() => {
    console.log(`server is running on port ${port}`);
})

app.use(express.static('public'))
