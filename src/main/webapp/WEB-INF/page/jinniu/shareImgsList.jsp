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
	<title>照片集锦</title>
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
			var dataUrl = baseUrl + "/dataImgs";
			
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
					colNames : ['动态ID','用户id','图片1','图片2','图片3', '图片4', '图片5','图片6','图片7','图片8','图片9','操作'],
					colModel : [
						{name : 'id',index : 'id',align : "center",width : 25},
						{name : 'userId',index : 'userId',align : "center",width : 25},
						{name : 'img1',index : 'img1',align : "center",width : 80,
							formatter:function(cellvalue, options, rowObject){
							if(rowObject.img1 == ''){
							   return '';
							}
								return "<img src="+rowObject.img1+" height='60' width='80'>";
							},
						},
                       {name : 'img2',index : 'img2',align : "center",width : 80,
                       		formatter:function(cellvalue, options, rowObject){
                       			return "<img src="+rowObject.img2+" height='60' width='80'>";
                       		},
                       	},
                       	{name : 'img3',index : 'img3',align : "center",width : 80,
                        	formatter:function(cellvalue, options, rowObject){
                        		return "<img src="+rowObject.img3+" height='60' width='80'>";
                        	},
                        },
                       	{name : 'img4',index : 'img4',align : "center",width : 80,
                       		formatter:function(cellvalue, options, rowObject){
                       			return "<img src="+rowObject.img4+" height='60' width='80'>";
                       		},
                       	},
                       {name : 'img5',index : 'img5',align : "center",width : 80,
                                    formatter:function(cellvalue, options, rowObject){
                                    	return "<img src="+rowObject.img5+" height='60' width='80'>";
                                    },
                       },
                       {name : 'img6',index : 'img6',align : "center",width : 80,
                                    formatter:function(cellvalue, options, rowObject){
                                    	return "<img src="+rowObject.img6+" height='60' width='80'>";
                                    },
                        },
                        {name : 'img7',index : 'img7',align : "center",width : 80,
                                   formatter:function(cellvalue, options, rowObject){
                                   	return "<img src="+rowObject.img7+" height='60' width='80'>";
                                   },
                        },
                       {name : 'img8',index : 'img8',align : "center",width : 80,
                                   formatter:function(cellvalue, options, rowObject){
                                        return "<img src="+rowObject.img8+" height='60' width='80'>";
                                   },
                       },
                       {name : 'img9',index : 'img9',align : "center",width : 80,
                                   formatter:function(cellvalue, options, rowObject){
                                        return "<img src="+rowObject.img9+" height='60' width='80'>";
                                   },
                       },

						{name : 'operate',index : 'operate',align : "center",width : 80,
							formatter:function(cellvalue, options, rowObject){
								return formatterOperate(options.rowId,rowObject.status,baseUrl);
							},
						}

					],
					autowidth:true,
					height:600,
					rowNum : 15,
					pager : '#goods_pager',
					rowList : [15, 20, 30],
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

		<!-- grid内容展示区域 -->
		<table id="goods_list"></table>
		<div id="goods_pager"></div>

	</div>

</body>