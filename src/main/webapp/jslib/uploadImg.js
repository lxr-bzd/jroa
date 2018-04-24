
function imgUpload(obj) {
	
	var imgBox = '#' + obj.imgBox;
	var inputBox = '#' + obj.inputBox;
	var num = obj.num;
	if(obj.init&&obj.init.length>0)addImg(obj.init,imgBox);

	$(inputBox).find('input[type=file]').change(onSelectFile);
	
function onSelectFile(e){
	if($(imgBox).find(">div").length>=num){
		obj.onOutof();
		return;
	}
	addNewContent($(e.target),imgBox);
	var f = $('<input type="file"  title="请选择图片" accept="image/png,image/jpg,image/gif,image/JPEG">')
	f.change(onSelectFile);
	$(inputBox).html(f);
}


function addImg(files,imgBox){
	
	for (var i = 0; i < files.length; i++) {
		var fimg = $('<img class="img_div"'+' alt=' + files[i].src + ' src="'+files[i].src+'" >');
		fimg.click(imgDisplay);
		var item = $('<div class="imgContainer"><p class="imgDelete">删除</p></div>');
		item.find("p").click(removeImg);
		item.append(fimg);
		if(files[i].form)item.append(files[i].form);
		
		$(imgBox).append(item);
		
	}
	
}

//图片展示
function addNewContent(imgFile,imgBox) {

	imgFile.hide();
	
	var imgName = imgFile[0].files[0].name;
	var fimg = $('<img  title=' + imgName + 'class="img_div"'+' alt=' + imgName + ' src=' +' >');
	
	setImg(imgFile,fimg)
	fimg.click(imgDisplay);
	var item = $('<div class="imgContainer"><p class="imgDelete">删除</p></div>');
	item.find("p").click(removeImg);
	item.append(fimg);
	item.append(imgFile);
	$(imgBox).append(item);
	onChangeImgBox($(imgBox));
	
}


function onChangeImgBox(imgBox){
	var name = imgBox.attr("data-fname");
	imgBox.find("input[type=file]").each(function(i,e){
		$(e).attr("name",name);
		});
	
}


function removeImg(e) {
	var box = $(e.target).parent().parent();
	$(e.target).parent().remove();
	onChangeImgBox(box);
}


//图片灯箱
function imgDisplay(e) {
	var src = $(e.target).attr("src");
	var imgHtml = $('<div style="display:table;width: 100%;height: 100vh;overflow: auto;background: rgba(0,0,0,0.5);text-align: center;position: fixed;top: 0;left: 0;z-index: 1000;"><div style="display: table-cell;vertical-align: middle;"><img src=' + src + ' /></div><p style="font-size: 50px;position: fixed;top: 30px;right: 30px;color: white;cursor: pointer;" >×</p></div>');
	imgHtml.click(closePicture);
	$('body').append(imgHtml);
}
//关闭
function closePicture(e) {
	$(e.target).parent("div").remove();
}

//图片预览路径
function setImg(file,img) {
	  var ifile = file[0].files[0];
      var reader = new FileReader();
      reader.readAsDataURL(ifile);
      reader.onload = function(e){
    	  $(img).attr("src",this.result);
      }
  }


}




//图片灯箱
function imgDisplay(e) {
	var src = $(e).attr("src");
	var imgHtml = $('<div style="display:table;width: 100%;height: 100vh;overflow: auto;background: rgba(0,0,0,0.5);text-align: center;position: fixed;top: 0;left: 0;z-index: 1000;"><div style="display: table-cell;vertical-align: middle;"><img src=' + src + ' /></div><p style="font-size: 50px;position: fixed;top: 30px;right: 30px;color: white;cursor: pointer;" >×</p></div>');
	imgHtml.click(closePicture);
	$('body').append(imgHtml);
}
//关闭
function closePicture(e) {
	$(e.target).parent("div").remove();
}

