(function($){
	$.fn.extend({
	lxrForm:function() {
		$lxr.form.select(this);
	}
	})
	})(jQuery);



/**
 * 扩展 js String replaceAll 方法
 * 使用方法类似JAVA的replaceAll
 * @param reallyDo
 * @param replaceWith
 * @param ignoreCase
 * @returns
 */
String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {
	if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
		return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")),
				replaceWith);
	} else {
		return this.replace(reallyDo, replaceWith);
	}
}
/**
 * 扩展js date类型format方法
 * 使用方法类似JAVA,new Date().format("yyyy-MM-dd hh:mm:ss");
 * @param format
 * @returns
 */
Date.prototype.format = function (format) 
{
    var o = {
        "M+": this.getMonth() + 1, //month 
        "d+": this.getDate(),    //day 
        "h+": this.getHours(),   //hour 
        "m+": this.getMinutes(), //minute 
        "s+": this.getSeconds(), //second 
        "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter 
        "S": this.getMilliseconds() //millisecond 
    }
    if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
    (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o) if (new RegExp("(" + k + ")").test(format))
        format = format.replace(RegExp.$1,
      RegExp.$1.length == 1 ? o[k] :
        ("00" + o[k]).substr(("" + o[k]).length));
    return format;
}

$.fn.serializeObject = function()
{
   var o = {};
   var a = this.serializeArray();
   $.each(a, function() {
       if (o[this.name]) {
           if (!o[this.name].push) {
               o[this.name] = [o[this.name]];
           }
           o[this.name].push(this.value || '');
       } else {
           o[this.name] = this.value || '';
       }
   });
   return o;
};

frontWithZero=function(num, n) {  
    var len = num.toString().length;  
    while(len < n) {  
        num = "0" + num;  
        len++;  
    }  
    return num;  
}

var Tools = {};

Tools.update = function(dataObj,pobj){
	
	for ( var i in dataObj) {
		pobj[i] = dataObj[i];
	}
	
}


Tools.beginningMonth = function(date){
	var d = date;
	d.setDate(1);
	return d;
}

Tools.endMonth = function(date){
	var d = date;
	hh = d;
	d.setMonth(d.getMonth()+1);
	
	d.setDate(0);
	return d;
}









var $lxr = {};

$lxr.dialog = function(init,fun,params) {
    if ($(".lxr_dialog").length > 0) {
        $(".lxr_dialog").remove();
    } 
    
    
    var content = "";
    if(params.content)
    	content = params.content;
    var title = "信息";
    if(params.title)
    	title = params.title;
    
    
    
    var html = "<div class='modal fade lxr_dialog'  >"
            + "<div class='modal-backdrop in' style='opacity:0; '></div>"
            + "<div class='modal-dialog' style='z-index:2901; margin-top:60px; width:80%; '>"
            + "<div class='modal-content'>"
            + "<div class='modal-header'  style='font-size:16px; '>"
            + "<span class='glyphicon glyphicon-envelope'>&nbsp;</span>"+title+"<button type='button' class='close' data-dismiss='modal'>"
            + "<span style='font-size:20px;  ' class='glyphicon glyphicon-remove'></span><tton></div>"
            + "<div class='modal-body text-center'  style='font-size:18px; '>"
            + content
            + "</div>"
            + "<div class='modal-footer ' style=''>"
            + "<button class='btn btn-danger ' id='confirmOk' >确定<tton>"
            + "<button class='btn btn-info ' data-dismiss='modal'>取消<tton>"
            + "</div>" + "</div></div></div>";
    var lxr_dialog = $(html);
    $("body").append(lxr_dialog);

    if(typeof(init)=="function")
    	init(lxr_dialog.find('.modal-body'));
    
    lxr_dialog.modal("show");
    $("#confirmOk").on("click", function() {
    	if(typeof(fun)=="function"&& fun(lxr_dialog.find('.modal-body'),lxr_dialog)===false)
    		return;
    	lxr_dialog.modal("hide");
      ; // 执行函数
    });
}


$lxr.confirm = function(params,fun) {
    if ($("#lxr_confirm").length > 0) {
        $("#lxr_confirm").remove();
    } 
    
    
    var content = "";
    if(params.content)
    	content = params.content;
    var title = "信息";
    if(params.title)
    	title = params.title;
    
    
    
    var html = "<div class='modal fade' id='lxr_confirm' >"
            + "<div class='modal-backdrop in' style='opacity:0; '></div>"
            + "<div class='modal-dialog' style='z-index:2901; margin-top:60px; width:400px; '>"
            + "<div class='modal-content'>"
            + "<div class='modal-header'  style='font-size:16px; '>"
            + "<span class='glyphicon glyphicon-envelope'>&nbsp;</span>"+title+"<button type='button' class='close' data-dismiss='modal'>"
            + "<span style='font-size:20px;  ' class='glyphicon glyphicon-remove'></span><tton></div>"
            + "<div class='modal-body text-center' id='myConfirmContent' style='font-size:18px; '>"
            + content
            + "</div>"
            + "<div class='modal-footer ' style=''>"
            + "<button class='btn btn-danger ' id='confirmOk' >确定<tton>"
            + "<button class='btn btn-info ' data-dismiss='modal'>取消<tton>"
            + "</div>" + "</div></div></div>";
    $("body").append(html);

    $("#lxr_confirm").modal("show");

    $("#confirmOk").on("click", function() {
        $("#lxr_confirm").modal("hide");
        fun(params); // 执行函数
    });
}


$lxr.hint = function(msg,f) {
	  top.art.dialog(
		        {
		            content:msg,
		            lock:true,
		            style:'succeed noClose'
		        },
		        function(){
		        	if(typeof(f)=="fuction")f(); 
		        },
		        function(){
		           // alert('你点了取消');
		        }
		                 );
	
	
}




/**
 * 
 * 
 * var l =  {title:"",items:[
		{name:"n",val:"v"}
	,{name:"n",val:"v",type:"img"}
	,{name:"n",val:"k1",type:"enum",enums:{k1:"1",k2:"2"} }]}
	}
 * 
 * json 转详情html
 */
$lxr.infoModal = function(json){
	
	
	var html = '<ul class="forminfo">';
	
	if(!(json.items instanceof Array))return "--";
	
	for (var i = 0; i < json.items.length; i++) {
		
		var val = json.items[i].val;
		switch (json.items[i].type) {
		case "img":
			html+='<li><label>'+json.items[i].name+'：</label><img src="'+json.items[i].val+'" alt="" style="width:100px;height: 100px;"></li>'
			break;
		case "enum":
			
			html+='<li><span>'+json.items[i].name+'：</span><input  value="'+json.items[i].enums[val]+'" type="text" class="form-control input-primary input-sm w260"></li>'
			
			break;
		default:
			html+='<li><span>'+json.items[i].name+'：</span><input  value="'+json.items[i].val+'" type="text" class="form-control input-primary input-sm w260"></li>'
				
			break;
		}
		
		
		
	}
	
	html+='</ul>'
	$lxr.modal({html:html});
	
	
}


$lxr.modal = function(p){
	
	
	var title = (p.title)?title:'详情';
	var type = 'info';
	
	
	var modal = $("#lxr-modal");
	if(modal.length<1)
		modal=$('<div class="modal fade" id="lxr-modal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">'
				+'<div class="modal-dialog">                                                                         '
				+'    <div class="modal-content">                                                                                       '
				+'        <div class="modal-header">                                                                                   '
				+'            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>             '
				+'            <h4 class="modal-title" id="myModalLabel" >'+title+'</h4>                                                 '
				+'        </div>                                                                                                       '
				+'        <div class="modal-body">                                                                                     '
				+'			                                                                                                           '
				+'	                                                                                                                   '
				+'                                                                                                                     '
				+'      </div>                                                                                                         '
				+'        <div class="modal-footer">                                                                                   '
				+'            <button type="button" class="btn btn-default" data-dismiss="modal">确定</button>                         '      
				+'        </div>                                                                                                       '
				+'    </div><!-- /.modal-content -->                                                                                   '
				+'</div><!-- /.modal -->                                                                                               '
              +'</div>');                                                                                                            
	
	
    $("body").append(modal);
    modal.modal('show');
    
    modal.find(".modal-body").html("加载中。。。");
    if(p.html)	modal.find(".modal-body").html(p.html);
    
    
    if(p.url)
	$.ajax({ 
		type: "get", 
		dataType:"html",
		url: p.url, 
		beforeSend: function(XMLHttpRequest){ 
		
		}, 
		success: function(data, textStatus){ 
			modal.find(".modal-body").html(data);
		}, 
		complete: function(XMLHttpRequest, textStatus){ 
		//alert("加载完成！"); 
		}, 
		error: function(){ 
			modal.find(".modal-body").html("加载错误！");
		} 
		}); 
	
	
}









$lxr.trimObject = function(obj){
	
	for ( var i in obj) {
		if(obj[i]===""||obj[i]==null)
			delete obj[i];
	}
	return obj;
	
}


$lxr.scroll = function(b){
	
	$('body').animate({  
	    scrollTop: b.offset().top  
	}, 300);  
	
}
$lxr.isEmpty = function(obj){
	
	if(!obj)return true;
	
	if((obj instanceof Array)&&obj.length<1)return true;
	
	return false;
	
}



$lxr.tree = function(array,op){
	
	
	if(!op)op = {};
	
	var pidname = !op.pidname?"pid":op.pidname;
	var childname = op.childname?op.childname:"childs";
	var idname = op.idname?op.idname:"id";
	
	var root = [];
	for (var i = 0; i < array.length; i++) {
		if(op.rootval==array[i][pidname])
			root.push(array[i]);
		
		
		var pid = array[i][idname];
		
		array[i].childs = getbyPid(array,pid);
	}
	
	
	
	function getbyPid(array,pid){
		
		var l = [];
		 for (var i = 0; i < array.length; i++) {
			if(array[i][pidname]==pid)
				l.push(array[i]);
		}
		 
		 return l;
	}
	
	
	
	
	
	
	return root;
	
}





$lxr.form = {};

$lxr.form.select = function(form){
	form.find("select.lxr-select").each(function(i,e){
		
		var select = $(e);
		
		var p = {};
		p.url = select.attr("data-url");
		p.val = select.attr("data-val");
		p.name = select.attr("data-name");
		p.root = select.attr("data-root");
		
		
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
					
						
				
					
					
				}else{
					console.log(JSON.stringify(p)+":返回数据错误");
					
				}
			}
		});
		
		
	});
	
}



$lxr.form.initSelect = function(selects,attr){
	selects.each(function (i,e) {
		   var v = $(e).attr(attr);
		   
		$(e).val(v);
	});
}





$lxr.toast = function (msg,duration){
    duration=isNaN(duration)?1100:duration;
    var m = document.createElement('div');
    m.innerHTML = msg;
    m.style.cssText="font-size: 18px;line-height:2em;width: "+(msg.length+2)+"em;opacity: 0.7;height: 2em;left: 0;right: 0;top: 0;bottom: 0;margin: auto;  color: rgb(255, 255, 255);text-align: center;border-radius: 5px;position: fixed;z-index: 999999;background: rgb(0, 0, 0);";
    document.body.appendChild(m);
    setTimeout(function() {
        var d = 0.4;
       m.style.webkitTransition = '-webkit-transform ' + d + 's ease-in, opacity ' + d + 's ease-in';
        m.style.opacity = '0';
        setTimeout(function() { document.body.removeChild(m) }, d * 1000);
    }, duration);
}









