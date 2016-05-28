<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="../jfz/static/common/css/input_file.css" type="text/css">
    <link rel="stylesheet" href="../jfz/static/common/css/input_text.css" type="text/css">
    <link rel="stylesheet" href="../jfz/static/common/css/add_form.css" type="text/css">
	<title>金币商城</title>
	<jsp:include page="/jfz/static/common/jsp/header.jsp" />
	<jsp:include page="/jfz/static/common/jsp/bottom.jsp" />
	
	
	<script type="text/javascript"  src="../jfz/static/common/js/ajaxfileupload.js"></script>
	<script type="text/javascript"  src="../jfz/static/common/js/formatter.js"></script>
	<script type="text/javascript"  src="../jfz/static/common/js/common.js"></script>
	<script type="text/javascript"  src="../jfz/static/common/js/upload.js"></script>
	<script type="text/javascript"  src="../jfz/static/common/js/search.js"></script>
	<script type="text/javascript"  src="../jfz/static/common/js/down.js"></script>
	<script type="text/javascript"  src="../jfz/static/common/js/up.js"></script>
	<script type="text/javascript"  src="../jfz/static/common/js/add.js"></script>
	<script type="text/javascript"  src="../jfz/static/common/js/modify.js"></script>
	<script type="text/javascript">
	
			//获取数据的url
			var baseUrl = "${path}share";
			var dataUrl = baseUrl + "/data";
			
			//入口
			$(document).ready(function() {
				initUI();
				initGrid();
			});
			
			
			
			/**初始化ui*/
			function initUI() {
				$("#search_btn").button({
					icons: {
			        	primary: "ui-icon-search"
			      	},
			      	text:false
				});
				$(".clean_btn").button();
				$(".add_btn").button();
				$( "#begin_time" ).datetimepicker({showSecond: true,timeFormat:'HH:mm:ss'});
				$( "#end_time" ).datetimepicker({showSecond: true,timeFormat:'HH:mm:ss'});
				$( "#add_goods_dialog_form_begin_time" ).datetimepicker({showSecond: true,timeFormat:'HH:mm:ss'});
				$( "#add_goods_dialog_form_end_time" ).datetimepicker({showSecond: true,timeFormat:'HH:mm:ss'});
				$( "#create_time" ).datetimepicker({showSecond: true,timeFormat:'HH:mm:ss'});
				$( "#update_time" ).datetimepicker({showSecond: true,timeFormat:'HH:mm:ss'});
			}
			
			
			/**初始化grid*/
			function initGrid() {
				$("#goods_list").jqGrid({
					url : dataUrl,
					datatype : "json",
					colNames : ['动态ID','动态imgs','描述','被赞数', '浏览数', '评论数','用户id','状态','话题id','创建时间','操作'],
					colModel : [
						{name : 'id',index : 'id',align : "center",width : 25},
						{name : 'imgs',index : 'imgs',align : "center",width : 80,
							formatter:function(cellvalue, options, rowObject){
								var imgs = rowObject.imgs
								var img_urls = imgs.split(",");
								var hostname = "http://image.crossd.me/";
								return "<img src="+hostname + img_urls[0]+" height='60' width='80'>";
							},
						},
						{name : 'description',index : 'description',align : "center",width : 80},
						{name : 'praiseCount',index : 'praiseCount',align : "center",width : 30},
						{name : 'scanCount',index : 'scanCount',align : "center",width : 80},
						{name : 'commentCount',index : 'commentCount',align : "center",width : 50},
						{name : 'userId',index : 'userId',align : "center",width : 50},
						{name : 'status',index : 'status',align : "center",width : 50,
							formatter:function(cellvalue, options, rowObject){
								return formatterStatus(rowObject.status);
							},
						},
						{name : 'topicId',index : 'topicId',align : "center",width : 50,sortable:false},
						{name : 'createTime',index : 'createTime',align : "center",width : 50,sortable:false},
						{name : 'operate',index : 'operate',align : "center",width : 80,
							formatter:function(cellvalue, options, rowObject){
								return formatterOperate(options.rowId,rowObject.status,baseUrl);
							},
						}

					],
					autowidth:true,
					height:600,
					rowNum : 13,
					pager : '#goods_pager',
					rowList : [13, 20, 30],
					gridComplete: function(){
						$(".viewGoods_btn").button();
						$(".upGoods_btn").button();
						$(".downGoods_btn").button();
						$(".deleteGoods_btn").button();
						$(".sumbit").button();
						$(".cancel").button();
					},
					viewrecords : true,
					caption : "商品列表"
				}).jqGrid('navGrid', '#goods_pager', {
					edit : false,
					add : false,
					del : false,
					search:false
				});
			}
		</script>
    <script type="text/javascript">
        $(function() {
            /* For zebra striping */
            $(".add_form table tr:nth-child(odd)").addClass("odd-row");
            /* For cell text alignment */
            $(".add_form table td:first-child,.add_form table th:first-child").addClass("first");
            /* For removing the last border */
            $(".add_form table td:last-child,.add_form table th:last-child").addClass("last");
            
            
        });
    </script>
</head>



<body>

	<div>

		<!-- 新增商品按钮 -->
		<table>
			<tr>
				<td><input type='button' id='add_coins_store_button' class='add_btn' value='新增商品' onclick="popAddDialog('#addGoodsDialogForm','#add_coins_store_button')" /></td>
				<td><input type='button' class='clean_btn' value='清空筛选' onclick="cleanFilter()"></td>
				
				<td hidden="true">
				
								<input type="file" id="upload_excel" name="upload_excel"  onchange="uploadCardExcelAsync('${path}coinsStore','upload_excel')" />

				</td>
				<td><input type='button' class='clean_btn' value='录入卡券' onclick="jQuery('#upload_excel').click()"></td>
				
				
				<td style="width: 400px">&nbsp;</td>
				<td>
                    <a href="../jfz/static/file/卡券模板.xls">
                        <input type='button' class='clean_btn' value='下载卡券模板'>
                    </a>
                </td>
			</tr>
		</table>
		<br>
		<!-- 搜索服务 -->
			<form id="goods_search_form">
				<table>
					<tr>
						<td>
							<label>商品ID</label>
						</td>
						<td>
							<input type="text" name="id" id="filter_0">
						</td>
						<td>
							<label>商品名称</label>
						</td>
						<td>
							<input type="text" name="name" id="filter_1">
						</td>
					</tr>
					
					<tr>
						<td>
							<label>商品类型</label>
						</td>
						<td>
							<select  name="consumable_type_id" id="filter_2" style="width:172px" onchange="searchClick('#search_btn')">
								<option value="">全部</option>
								<c:forEach     items="${ types}" var="type">
								<option value="${type.id }">${type.name }</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<label>虚拟币类型</label>
						</td>
						<td>
							<select  name="virasset_type_id" id="filter_3" style="width:172px" onchange="searchClick('#search_btn')">
								<option value="">全部</option>
								<option value="1">雪币</option>
								<option value="2">金币</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<label>平台</label>
						</td>
						<td>

							<select  name="platform" id="filter_4" style="width:172px" onchange="searchClick('#search_btn')">
								<option value="">全部</option>
								<option value="1">滚雪球</option>
								<option value="2">金斧子APP</option>
								<option value="3">金融港</option>
							</select>
						</td>
						<td>
							<label>商品状态</label>
						</td>
						<td>
							<select name="status" id="filter_5" style="width:172px" onchange="searchClick('#search_btn')">
							<option value="">全部</option>
							<option value="0">下架</option>
							<option value="1">上架</option>
							</select>
						</td>
						<td>
							<a style="height:18px;" href="javascript:;" id='search_btn' onclick="commonSearch('${path}coinsStore','#goods_search_form','#goods_list')">搜索</a>
						</td>
						
						
						
						
					</tr>
				</table>
			</form>
		<br>

		<!-- grid内容展示区域 -->
		<table id="goods_list"></table>
		<div id="goods_pager"></div>

	</div>

		
	<!-- 新增商品对话框UI -->
	<iframe name="bannerImageframe" width="450" height="45" id="bannerImageframe" src="about:blank" frameborder="0" marginwidth="0" scrolling="no">
	</iframe>
	<form id="addGoodsDialogForm" method="post" style="display: none;" enctype="multipart/form-data" target="bannerImageframe">
		<table cellspacing="0" class="add_form" align="center">

            <tr class="odd-row">
                <th class="first">关键字</th>
                <th>填入值</th>
                <th>关键字</th>
                <th class="last">填入值</th>
            </tr>
		
			<tr>
				<td class="first"><label>商品id</label></td>
				<td><label>（自动生成）</label></td>
				<td><label>商品名称</label></td>
				<td class="last"><input class="input_text" type="text" name="name" maxlength="10" placeholder="仅限10个字符"></td>
			</tr>
			<tr class="odd-row">
				<td class="first"><label>副标题</label></td>
				<td class="last" colspan="3"><input class="input_text2" type="text" style="width:505px" name="sub_name" maxlength="25" placeholder="仅限25个字符"></td>
			</tr>

            <tr>
                <td colspan="4" class="first last input_text"></td>
            </tr>
			<tr class="odd-row">
				<td class="first"><label>实际价格</label></td>
				<td><input type="text" class="input_text2" name="price" maxlength="11" placeholder="只允许填价格" onkeyup="clearNoNum(this)"></td>
				<td><label>库存</label></td>
				<td class="last"><input type="text" class="input_text2" name="stock" maxlength="9" placeholder="可输入数字或无限" onkeyup="clearNumAndInfinite(this)"></td>
			</tr>
			<tr>
				<td class="first"><label>虚拟币价格</label></td>
				<td><input type="text" class="input_text" name="virasset_value" maxlength="9" placeholder="只允许数字" onkeyup="clearOnlyNum(this)"></td>
				<td><label>虚拟币类型</label></td>
				<td class="last">
				<select class="input_text" name="virasset_type_id" style="width:165px" >
					<option value="2">金币</option>
					<option value="1">雪币</option>
				</select>
				</td>
			</tr>
			<tr class="odd-row">
				<td class="first"><label>按钮文案</label></td>
				<td><input type="text" class="input_text2" name="button_title" maxlength="10" placeholder="仅限10个字符"></td>
				<td><label>商品权重值</label></td>
				<td class="last"><input type="text" class="input_text2" name="position" maxlength="9" onkeyup="clearOnlyNum(this)" placeholder="只允许纯数字，越大越前"></td>
			</tr>

            <tr>
                <td colspan="4" class="first last input_text"></td>
            </tr>

			<tr class="odd-row">
				<td class="first"><label>商品类型</label></td>
				<td>
				<select class="input_text2" name="consumable_type_id" style="width:165px" >
					<c:forEach     items="${ types}" var="type">
					<option value="${type.id }">${type.name }</option>
					</c:forEach>
				</select>
				</td>
				<td><label>商品状态</label></td>
				<td class="last">
					<select class="input_text2" name="status" style="width:165px" >
						<option value="1">上架</option>
						<option value="0">下架</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="first"><label>商品有效期开始时间</label></td>
				<td><input class="input_text" type="text" id="add_goods_dialog_form_begin_time"  name="begin_time"></td>
				<td><label>商品有效期结束时间</label></td>
				<td class="last"><input class="input_text" type="text" id="add_goods_dialog_form_end_time" name="end_time"></td>
			</tr>


            <tr>
                <td colspan="4" class="first last input_text"></td>
            </tr>

			<tr class="odd-row">
				<td class="first"><label>接入平台</label></td>
				<td>
				<select class="input_text2" name="platform" style="width:165px" >
					<option value="1">滚雪球</option>
					<option value="2">金斧子APP</option>
					<option value="3">金融港</option>
				</select>
				</td>
				<td><label>客户端</label></td>
				<td class="last">
				<select class="input_text2" name="client" style="width:165px" >
					<option value="mobile">mobile</option>
					<option value="web">web</option>
				</select>
				</td>
			</tr>
			<tr>
				<td class="first"><label>描述</label></td>
				<td class="last" colspan="3">
					<textarea class="input_text"  name="description" maxlength="100" placeholder="仅限100个字符" rows="3" cols="54"></textarea>
				</td>
			</tr>
			<tr class="odd-row">
				<td class="first"><label>商品icon</label></td>
				<td><input type="button" class="file" value="上传图片" onclick="jQuery('#add_goods_dialog_form_img_file').click()" /></td>
				<td class="last" colspan="2">
				    <input type="hidden" name="img" value="add_goods_dialog_form_icon_img">
				    <img id="add_goods_dialog_form_icon_img"  height="100" width="100" hidden="true">
                </td>
				<td hidden="true"><input hidden="true" type="file" name="add_goods_dialog_form_img_file" id="add_goods_dialog_form_img_file" style="display:none;" onchange="uploadFile('${path}coinsStore','#addGoodsDialogForm','#add_goods_dialog_form_img_file')" /></td>
				<td hidden="true">
				    <input type="hidden" name="input" value="add_goods_dialog_form_img_url">
				    <input id="add_goods_dialog_form_img_url" name="img_url" hidden="true" />
                </td>
			</tr>
			<tr>
				<td class="last" colspan="2">
					<input type='button' class='sumbit' value='提交' onclick="submitAddDialog('${path}coinsStore','#addGoodsDialogForm','#goods_list')" />
				</td>
				<td class="last" colspan="2">
					<input type='button' class='cancel' value='取消' onclick="cancelAddDialog('#addGoodsDialogForm')" />
				</td>
			</tr>
			
		</table>
	</form>	
		

	<!-- 查看与修改对话框UI -->
	<form id="showGoodsDialogForm" method="post" style="display: none;" enctype="multipart/form-data" target="bannerImageframe">
		<table cellspacing="0" class="add_form" align="center">

            <tr class="odd-row">
                <th class="first">关键字</th>
                <th>填入值</th>
                <th>关键字</th>
                <th class="last">填入值</th>
            </tr>

			<tr>
				<td class="first"><label>商品id</label></td>
				<td><label id="id_1"></label><input type="text" name="id" id="id" hidden="true" ></td>
				<td><label>商品名称</label></td>
				<td class="last"><input class="input_text" type="text" name="name" id="name" maxlength="10" placeholder="仅限10个字符"></td>
			</tr>
			<tr class="odd-row">
				<td class="first"><label>副标题</label></td>
				<td class="last" colspan="3"><input class="input_text2" type="text" style="width:505px" id="sub_name" name="sub_name" maxlength="25" placeholder="仅限25个字符"></td>
			</tr>

            <tr>
                <td colspan="4" class="first last input_text"></td>
            </tr>

			<tr class="odd-row">
				<td class="first"><label>实际价格</label></td>
				<td><input type="text" class="input_text2" id="price" name="price" maxlength="11" placeholder="只允许填价格" onkeyup="clearNoNum(this)"></td>
				<td><label>库存</label></td>
				<td class="last"><input type="text" class="input_text2" id="stock" name="stock" maxlength="9" placeholder="可输入数字或无限" onkeyup="clearNumAndInfinite(this)"></td>
			</tr>

			<tr>
				<td class="first"><label>虚拟币价格</label></td>
				<td><input type="text" class="input_text" id="virasset_value" name="virasset_value" maxlength="9" placeholder="只允许数字" onkeyup="clearOnlyNum(this)"></td>
				<td><label>虚拟币类型</label></td>
				<td class="last">
				<select class="input_text" id="virasset_type_id" name="virasset_type_id" style="width:165px" >
					<option value="1">雪币</option>
					<option value="2">金币</option>
				</select>
				</td>
			</tr>

			<tr class="odd-row">
				<td class="first"><label>按钮文案</label></td>
				<td><input type="text" class="input_text2"  id="button_title" name="button_title" maxlength="10" placeholder="仅限10个字符"></td>
				<td><label>商品权重值</label></td>
				<td class="last"><input type="text" class="input_text2" id="position" name="position" maxlength="9" onkeyup="clearOnlyNum(this)" placeholder="只允许纯数字"></td>
			</tr>

            <tr>
                <td colspan="4" class="first last input_text"></td>
            </tr>

			<tr class="odd-row">
				<td class="first"><label>商品类型</label></td>
				<td>
				<select class="input_text2" id="consumable_type_id" name="consumable_type_id" style="width:165px" >
					<c:forEach     items="${ types}" var="type">
					<option value="${type.id }">${type.name }</option>
					</c:forEach>
				</select>
				</td>
				<td><label>商品状态</label></td>
				<td class="last">
					<select class="input_text2" id="status" name="status" style="width:165px" >
						<option value="1">上架</option>
						<option value="0">下架</option>
					</select>
				</td>
			</tr>

			<tr>
				<td class="first"><label>商品有效期开始时间</label></td>
				<td><input class="input_text" type="text" id="begin_time" name="begin_time"></td>
				<td><label>商品有效期结束时间</label></td>
				<td class="last"><input class="input_text" type="text" id="end_time" name="end_time"></td>
			</tr>

			<tr class="odd-row">
				<td class="first"><label>生成时间</label></td>
				<td><label id="create_time"></label></td>
				<td><label>更新时间</label></td>
				<td class="last"><label id="update_time"></label></td>
			</tr>


            <tr>
                <td colspan="4" class="first last input_text"></td>
            </tr>

			<tr class="odd-row">
				<td class="first"><label>接入平台</label></td>
				<td>
				<select class="input_text2" id="platform" name="platform" style="width:165px" >
					<option value="1">滚雪球</option>
					<option value="2">金斧子APP</option>
					<option value="3">金融港</option>
				</select>
				</td>
				<td><label>客户端</label></td>
				<td class="last">
				<select class="input_text2" id="client" name="client" style="width:165px" >
					<option value="mobile">mobile</option>
					<option value="web">web</option>
				</select>
				</td>
			</tr>

			<tr>
				<td class="first"><label>描述</label></td>
				<td colspan="3">
					<textarea class="input_text" id="description" name="description" maxlength="100" placeholder="仅限100个字符" rows="3" cols="54"></textarea>
				</td>
			</tr>

			<tr class="odd-row">
				<td class="first"><label>商品icon</label></td>
				<td><input type="button" class="file" value="修改图片" onclick="jQuery('#img_file').click()" /></td>
				<td class="last" colspan="2">
				    <input type="hidden" name="img" value="icon_img">
				    <img id="icon_img" height="100" width="100">
                </td>
				<td hidden="true"><input type="file" name="img_file" id="img_file" style="display:none;" onchange="uploadFile('${path}coinsStore','#showGoodsDialogForm','#img_file')" /></td>
				<td hidden="true">
				    <input type="hidden" name="input" value="img_url">
				    <input id="img_url" name="img_url" hidden="true">
                </td>
			</tr>

			<tr>
				<td class="last" colspan="2">
					<input type='button' class='sumbit' value='提交' onclick="submitModify('${path}coinsStore','#showGoodsDialogForm','#goods_list')" />
				</td>
				<td class="last" colspan="2">
					<input type='button' class='cancel' value='取消' onclick="cancelModify('#showGoodsDialogForm')" />
				</td>
			</tr>
		</table>
	</form>
</body>