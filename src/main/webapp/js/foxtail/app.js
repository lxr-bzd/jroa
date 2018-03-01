
$app = {loginUrl:'/jroa/login.do',imgUpload:"/jroa/image/upload.do"};

$app.getContext = function(){
	
	var context = window;	
	if(window.top)context = window.top;
	return context;
}

$app.request = function(url,call,param){
	$.ajax({ 
		type: "post", 
		dataType:"json",
		url: url, 
		data:((param&&param.param)?param.param:""),	
		beforeSend: function(XMLHttpRequest){ 
		
		}, 
		success: function(data, textStatus){
			if(data&&data.status==5)window.location.href = $app.loginUrl;
			call(data,textStatus);
		}, 
		complete: function(XMLHttpRequest, textStatus){ 
		if(param&&param.complete)
			param.complete(XMLHttpRequest, textStatus);
		}, 
		error: function(){ 
			if(param&&param.error)
				param.error();
		} 
		}); 
	
}


$app.confirm = function(msg,yes,no){
	
	var context = this.getContext();
	
	context.layer.confirm(msg, {
		  btn: ['确认','取消'] //按钮
		}, function(index){
			context.layer.close(index);
			
			if(yes)yes();
		
		}, function(){
			if(no)no();
		});
	
}

$app.confirmDelete = function(url,msg,after){
	
	var context = this.getContext();
	
	context.layer.confirm(msg, {
		  btn: ['确认','取消'] //按钮
		}, function(index){
			context.layer.close(index);
			
			$app.request(url,function(data){
					var json=data;
					
				    if(data.status==0){
				    	context.layer.alert('删除成功');
				    }else{
				    	context.layer.alert(data.msg,{icon: 7});
				    }
				    
				    
				    
					if(after)after();
					
				 });
		
		}, function(){
		 
		});
	
}

$app.alert = function(msg,call){
	
	var context = this.getContext();
	
	context.layer.alert(msg,{},function(index){
		if(call)call();
		context.layer.close(index);
		
	});
}

$app.warning = function(msg,call){
	
	var context = this.getContext();
	
	context.layer.alert(msg,{icon: 7},function(index){
		if(call)call();
		context.layer.close(index);
		
	});
}

$app.prompt = function(title,call,formType){
	
	if(!formType)formType = 2;
	 
	layer.prompt({title: title, formType: formType}, function(pass, index){
		  layer.close(index);
		  if(call)call(pass);
		 
		});
}


$app.dialog = function(url,onclose,param){
	
	var context = this.getContext();
	
	if(!param)param={};
	
	var height = param.height?param.height:'360px';
	var width = param.width?param.width:'520px';
	
	if(new Number(height.replace("px",""))>context.innerHeight)height=context.innerHeight+"px";
	if(new Number(width.replace("px",""))>context.innerWidth)width=context.innerWidth+"px";
	
	context.layer.open({
		  type: 2,
		  title: param.title?param.title:'编辑',
		  shadeClose: true,
		  maxmin: true,
		  skin: 'layui-layer-rim',
		  shade: 0.5,
		  area: [width, height],
		  content: url //iframe的url
		  ,end: function (a,b) {
              if(onclose)onclose();
          }
		});
	
	  
	
}




$app.loading = function(fun){
	var context = this.getContext();
	var id =  context.layer.msg('处理中。。。', {
		  icon: 16
		  ,shade: 0.6
		  ,time:0
		});
	
	fun(function(){
		context.layer.close(id);
	});
	
	
}

$app.btn = function(type,name,onclickText){
	
	if(typeof type == "object"){
		return '<button class="btn '+type.type+' btn-round btn-xs" onclick="'+onclickText+'">'
		+'<i class="glyphicon '+type.img+'"></i> '+name+'</button>';
	}
	
	
	
	switch (type) {
	case "edit":
		return '<button class="btn btn-info btn-round  btn-xs" onclick="'+onclickText+'">'
		+'<i class="glyphicon glyphicon-pencil"></i> '+name+'</button>';
		break;

	case "delete":
		return '<button class="btn btn-round btn-xs" onclick="'+onclickText+'">'
		+'<i class="glyphicon glyphicon-trash"></i> '+name+'</button>';
		break;
		
	case "add":
		return '<button class="btn btn-info btn-round  btn-xs" onclick="'+onclickText+'">'
		+'<i class="glyphicon glyphicon-plus"></i> '+name+'</button>';
		
		break;
	case "info":
		return '<button class="btn btn-success btn-round btn-xs" onclick="'+onclickText+'">'
		+'<i class="glyphicon glyphicon-search"></i> '+name+'</button>';
		
		break;
	case "auth":
		return '<button class="btn btn-success btn-round btn-xs" onclick="'+onclickText+'">'
		+'<i class="glyphicon glyphicon-ok"></i> '+name+'</button>';
		
		break;
		
	default:
		return "";
		break;
	}
	
}

$app.formatUi = function(type,val){
	
	switch (type) {
	case "state":
		if(val==0)
    		return "有效";
    	else
    		return "无效";
		break;
		
	default:
		return "";
		break;
	}
	
}

$app.tableUi={};
$app.tableUi.state = function(val){
	if(val==0)
		return "有效";
	else if(val==1)
		return "无效";
}

$app.tableUi.sex = function(val){
	if(val==1)
		return "男";
	else if(val==2)
		return "女";
}


$app.tableUi.date = function(val){
	
	if(!val)return "";
	return  new Date(new Number(val)).format("yyyy-MM-dd");
	
} 

$app.tableUi.time = function(val){
	
	if(!val)return "";
	return  new Date(new Number(val)).format("yyyy-MM-dd hh:mm:ss");
	
}

$app.form = function(exp){
	var fm = $(exp);
	fm.find("div.lxr_multipleSelect").each(function(i,e){
		$app.form.multipleSelect($(e));
		
	});
	fm.find("select.lxr-select").each(function(i,e){
		$app.form.select($(e));
		
	});
	
}

$app.form.select = function(select,config){
	//select: lxr-select
	//p={url:null,val:'',name:'',root:'data'}
	var p = eval("("+select.attr("data-model")+")");
	
		
		$.ajax({
			url:p.url,
			dataType : 'JSON',
			type:'post',
			success:function(data){
				
				var l = data;
				if(p.root)
				var ex  = p.root.split(",");
				else var ex = [];
				
				for (var i = 0; i < ex.length; i++) {
					l = l[ex[i]];
				}
				
				
				if(l instanceof Array){
					
					
					var html = '';
					for (var i = 0; i < l.length; i++) {
						html+='<option value="'+l[i][p.val]+'">'+l[i][p.name]+'</option>';
					}
					
					select.append(html);
					
					if(p.initVal)select.val(p.initVal);
				}else{
					console.log(JSON.stringify(p)+":返回数据错误");
					
				}
			}
		});
		
	
}




$app.form.multipleSelectVal = function(mselect){
	
	mselect = $(mselect);
	
	var val = mselect.find(">select:last").val();
	if(!val)
		return mselect.find(">select:last").prev().val();
	return val;
	
	
	
	
}


$app.form.multipleSelect = function(div){
	
	
	var model = eval("window."+div.attr("data-model"));
	
	var name = model.name?model.name:"name";
	var val = model.val?model.val:"val";
	
	
	model.getRoot(render);
	
	
	function render(arr){
		var html = '<select class="form-control"  style="display: inline;width:110px;" onchange=""><option value="">--请选择--</option>'
			for (var i = 0; i < arr.length; i++) {
				
				html+='<option value="'+arr[i][val]+'">'+arr[i][name]+'</option>';
			}
			html+='</select>';
		var h = $(html);
		h.change(onSelect);
			div.html(h);
		if(!model.init)return;
		var ch = h;
			for(var i = 0;i<model.init.length;i++){
				ch.val(model.init[i]).trigger('change');
				ch = h.next();
			}
		
			
	}
	
	
	function onSelect(e){
		var cselect = e.target;
		$(cselect).nextAll().remove();
		
		model.onSelect(cselect.value,function(arr){
			
			if(!arr||arr.length<1)return;
			
			var html = '<select class="form-control"  style="display: inline;width:110px;" onchange=""><option value="">--请选择--</option>'
				for (var i = 0; i < arr.length; i++) {
					html+='<option value="'+arr[i][val]+'">'+arr[i][name]+'</option>';
				}
				html+='</select>';
				var h = $(html);
				h.change(onSelect);
				$(cselect).after(h);
		});
		
		
		
		
		
	}
	
	

}

//$app.form.preSubmit start
$app.form.preSubmit = function(form){
	form = $(form);
	
	var inputs = form.find("input.lxr-format");
	inputs.each(function(i,e){
		finput($(e));
	});
	
	function finput(input){
		if(!input.attr("data-lxr"))
			return;
		
		var config = eval('(' + input.attr("data-lxr") + ')');
		
		switch (config.type) {
		case 'time':
			if(!input.val()){input.next().val('');	return;}
			input.next().val(new Date(input.val()).getTime());
			break;

		default:
			break;
		}
		
		
	}
}
//$app.form.preSubmit end

$app.form.format = function(form){
	form.find('input.lxr-format').each(function(i,e){
		
			_input($(e));
	});
	
	
	function _input(input){
		
		var json = input.attr("data-format");
		
		var config = eval('(' + json + ')');
		var val = config.val;
		switch (config.type) {
		case 'time':
			if(isNaN(val))return;
			input.val(new Date(new Number(val)).format(config.format));
			break;
		case 'enum':
			var f = config.enum;
			if(isNaN(val))return;
			input.val(f[val]);
			break;
			

		default:
			break;
		}
	}
	
	
}



