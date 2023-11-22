
const express = require('express');
const querystring = require("querystring");
const app = express();
const fs = require('fs');
const port = 8087;
const { exec } = require("child_process");
const ext = { 'sass': 'sass', 'cpp':'cc','node':'js', 'python':'py', 'bash':'sh', 'ruby':'rb', 'java':'java', 'go':'go', 'rust':'rs', 'ocaml':'ml', 'elixir':'exs','csharp':'cs','clojure':'clj','julia':'jl','r':'r','php':'php','perl':'pl','haskell':'hs','k':'k','lua':'lua','kotlin':'kt','c':'c','zsh':'zsh','vyxal':'vyxal','raku':'raku','j':'ijs','prolog':'prolog','jelly':'jelly','golfscript':'golfscript','dc':'dc','scala':'scala','apl':'apl','powershell':'sh','bqn':'bqn','fsharp':'fs'};

function callDocker(req,res,tmp,countInput) {
    var s="";
    console.log("script/launchvm.sh "+req.query.lang+" data/"+tmp+" "+req.query.countInput);
    exec("script/launchvm.sh "+req.query.lang+" data/"+tmp+" "+req.query.countInput, (error, stdout, stderr) => {
	if (error) {
	    res.send('{"code":1006,"msg":"error trying to execute virtual machine \''+error.cmd+'\' error message is \''+stderr+'\' stdout: '+stdout+'."}');
	    //s=JSON.stringify(error);
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
	
	res.send(output);
    });
}

app.get('/',(req,res) => {
    if (!('query' in req)) {
	res.send('{"code":1000,"msg":"query string expected."}');
	return;
    }
    if (!('lang' in req.query)) {
	res.send('{"code":1002,"msg":"lang field expected."}');
	return;
    }
    if (!('countInput' in req.query)) {
	res.send('{"code":10022,"msg":"countInput field expected."}');
	return;
    }
    let countInput=req.query.countInput;
    for (let i=0;i<countInput;++i) {
	if (!(('input'+i) in req.query)) {
	    res.send('{"code":10022,"msg":"input$i field expected."}');
	    return;
	}
    }
    if (!('code' in req.query)) {
	res.send('{"code":1003,"msg":"code field expected."}');
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
/*	
	    fs.mkdir('data/'+tmp+'/out', (err) => {
		if (err) {
		    console.error(err);
		    res.send('{"code":1004,"msg":"mkdir /out error."}');
		    return;
		}
		console.log('Directory '+tmp+'/in created successfully!');
*/	    
		if (!(req.query.lang in ext)) {
		    res.send('{"code":1005,"msg":"language not supported. Here is the list: '+JSON.stringify(Object.keys(ext)).replace(/"/g, '\'')+'."}');
		    return;
		}
		const myext = ext[req.query.lang];
		//querystring.unescape
		fs.writeFileSync('data/'+tmp+'/in/prog.'+myext,req.query.code);
		for (let i=0;i<countInput;++i) {
		    fs.writeFileSync('data/'+tmp+"/in/input"+i+".txt", req.query["input"+i]);
		}
		callDocker(req,res,tmp,countInput);
	    /* }); */
	}); 
    });

})
//app.get('/version.json', (req, res) => {
//  res.send('Hello World!')
//})
app.listen(port,() => {
    console.log(`server is running on port ${port}`);
})
app.use(express.static('public'))
