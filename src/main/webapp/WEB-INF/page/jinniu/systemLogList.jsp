<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="../jfz/static/common/css/input_file.css" type="text/css">
    <link rel="stylesheet" href="../jfz/static/common/css/input_text.css" type="text/css">
    <link rel="stylesheet" href="../jfz/static/common/css/add_form.css" type="text/css">
    <title>详细日志</title>
    <jsp:include page="/jfz/static/common/jsp/header.jsp" />
    <jsp:include page="/jfz/static/common/jsp/bottom.jsp" />
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
        var baseUrl = "${path}systemLog";
        var dataUrl = baseUrl + "/data";

        //入口
        $(document).ready(function() {
            initUI();
            initGrid();
            initAdminData();

        });

        /**从数据库获取下拉框数据*/
        function initAdminData(){
           // $("#filter_0").options.add(new Option("全部",""));
        }

        /**初始化ui*/
        function initUI() {
            $("#system_log_search_btn").button({
                icons: {
                    primary: "ui-icon-search"
                },
                text:false
            });
            $(".common_button").button();
            $(".clean_btn").button();
        }

        /**初始化grid*/
        function initGrid() {
            $("#system_log_list").jqGrid({
                url : dataUrl,
                datatype : "json",
                colNames : ['记录ID','用户名','操作模块','操作','操作时间','涉及类名','详细信息','详细信息'],
                colModel : [
                    {name : 'id',index : 'id',align : "center",width : 30,hidden : true},
                    {name : 'userName',index : 'userName',align : "center",width : 30},
                    {name : 'operateModule',index : 'operateModule',align : "center",width : 30,
                        formatter:function(cellvalue, options, rowObject){
                            return formatterOperateModule(rowObject.operateModule);
                        }
                    },
                    {name : 'operate',index : 'operate',align : "center",width : 30,
                        formatter:function(cellvalue, options, rowObject){
                            return formatterOperateDetail(rowObject.operate);
                        }
                    },
                    {name : 'operateTime',index : 'operateTime',align : "center",width : 30},
                    {name : 'className',index : 'className',align : "center",width : 100},
                    {name : 'description',index : 'description',align : "center",width : 200,hidden : true},
                    {name : 'detail',index : 'detail',align : "center",width : 30,
                        formatter:function(cellvalue, options, rowObject){
                            return formatterDetail(options.rowId);
                        }
                    }
                ],
                autowidth:true,
                height:600,
                rowNum : 21,
                pager : '#system_log_pager',
                rowList : [21, 30, 40],
                gridComplete: function(){
                    $(".view_btn").button();
                    $(".cancel").button();
                },
                viewrecords : true,
                caption : "详细列表"
            }).jqGrid('navGrid', '#system_log_pager', {
                        edit : false,
                        add : false,
                        del : false,
                        search:false
                    });
        }
    </script>
</head>
<body>
    <div>

        <!-- 清空筛选按钮 -->
        <table>
            <tr>
                <td><input type='button' class='clean_btn' value='清空筛选' onclick="cleanFilter4()"></td>
            </tr>
        </table>
        <br>

        <!-- 搜索服务 -->
        <form id="system_log_search_form">
            <table cellspacing="5">
                <tr>
                    <td>
                        <label>用户名</label>
                    </td>
                    <td>
                        <input type="text" name="userName" id="filter_0">
                    </td>
                    <td>
                        <label>操作模块</label>
                    </td>
                    <td>
                        <select type="text" name="operateModule" id="filter_1" style="width:172px" onchange="searchClick('#system_log_search_btn')">
                            <option value="">全部</option>
                            <option value="Admin">管理员</option>
                            <option value="CoinsMission">金币任务</option>
                            <option value="CoinsStore">金币商城</option>
                            <option value="ConsumableOrder">兑奖记录</option>
                            <option value="PropertyConfig">环境变量</option>
                            <option value="BatchMission">批量完成任务</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        <label>操作</label>
                    </td>
                    <td>
                        <select type="text" name="operate" id="filter_2" style="width:172px" onchange="searchClick('#system_log_search_btn')">
                            <option value="">全部</option>
                            <option value="Add">新增记录</option>
                            <option value="Modify">修改记录</option>
                            <option value="Down">下架操作</option>
                            <option value="Up">上架操作</option>
                            <option value="Charge">发货操作</option>
                            <option value="Login">登录操作</option>
                            <option value="UploadExcel">上传Excel</option>
                        </select>
                    </td>
                    <td>
                        <label>操作时间</label>
                    </td>
                    <td>
                        <input type="text" name="operateTime" id="filter_3">
                    </td>
                </tr>

                <tr>
                    <td>
                        <label>涉及类名</label>
                    </td>
                    <td>
                        <input type="text" name="className" id="filter_4">
                    </td>
                    <td colspan="3">
                        <a style="height:18px;width: 232px;" href="javascript:;" id='system_log_search_btn' onclick="commonSearch('${path}systemLog','#system_log_search_form','#system_log_list')">搜索</a>
                    </td>
                </tr>

            </table>
        </form>
        <br>
        <!-- grid内容展示区域 -->
        <table id="system_log_list"></table>
        <div id="system_log_pager"></div>
    </div>
        <form id="modify_system_log_dialog_form" method="post" style="display: none;" enctype="multipart/form-data">
            <table cellspacing="20"  align="center" >
                <tr>
                    <td colspan="2"><label>详细参数</label></td>
                    <td colspan="2"><textarea readonly="true" type="text" cols="50" rows="20" name="description" id="description"></textarea></td>
                </tr>
            </table>
        </form>

</body>
