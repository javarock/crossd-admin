<%--
  Created by IntelliJ IDEA.
  User: wise.wu
  Date: 15-8-29
  Time: 上午10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>




    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="../jfz/static/common/css/input_file.css" type="text/css">
    <link rel="stylesheet" href="../jfz/static/common/css/input_text.css" type="text/css">
    <link rel="stylesheet" href="../jfz/static/common/css/add_form.css" type="text/css">
    <title>环境变量</title>
    <jsp:include page="/jfz/static/common/jsp/header.jsp"/>
    <jsp:include page="/jfz/static/common/jsp/bottom.jsp"/>
    <script type="text/javascript" src="../jfz/static/common/js/formatter.js"></script>
    <script type="text/javascript" src="../jfz/static/common/js/common.js"></script>
    <script type="text/javascript" src="../jfz/static/common/js/upload.js"></script>
    <script type="text/javascript" src="../jfz/static/common/js/search.js"></script>
    <script type="text/javascript" src="../jfz/static/common/js/down.js"></script>
    <script type="text/javascript" src="../jfz/static/common/js/up.js"></script>
    <script type="text/javascript" src="../jfz/static/common/js/add.js"></script>
    <script type="text/javascript" src="../jfz/static/common/js/modify.js"></script>
    <script type="text/javascript">

        //获取数据的url
        var baseUrl = "${path}propertyConfig";
        var dataUrl = baseUrl + "/data";

        //入口
        $(document).ready(function () {
            loadComplete();
            initUI();
            initGrid();

        });

        /**设置单元格行高**/
        function loadComplete(){
            var grid = $("#property_config_list");
            var ids = grid.getDataIDs();
            for (var i = 0; i < ids.length; i++) {
                grid.setRowData ( ids[i], false, {height: 70+i*2} );
            }
        }

        /**初始化ui*/
        function initUI() {
            $("#search_btn").button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: false
            });
            $(".clean_btn").button();
            $(".common_button").button();
            $( ".timepicker" ).datetimepicker({showSecond: true,timeFormat:'HH:mm:ss'});
        }


        /**初始化grid*/
        function initGrid() {
            $("#property_config_list").jqGrid({
                url: dataUrl,
                datatype: "json",
                colNames: ['属性ID', '属性名称', '属性值', '描述', '状态', '生效时间', '失效时间', '创建时间', '更新时间', '类型','操作'],
                colModel: [
                    {name: 'ID', index: 'ID', align: "center", width: 20},
                    {name: 'PROP_NAME', index: 'PROP_NAME', align: "center", width: 80},
                    {name: 'PROP_VALUE', index: 'PROP_VALUE', align: "center", width: 80},
                    {name: 'DESC', index: 'DESC', align: "center", width: 80},
                    {name: 'ENABLED', index: 'ENABLED', align: "center", width: 30,
                        formatter:function(cellvalue, options, rowObject){
                            return formatterENABLED(rowObject.ENABLED);
                        }
                    },
                    {name: 'EFFECT_FROM', index: 'EFFECT_FROM', align: "center", width: 60},
                    {name: 'EFFECT_TO', index: 'EFFECT_TO', align: "center", width: 60},
                    {name: 'CREATE_TIME', index: 'CREATE_TIME', align: "center", width: 60},
                    {name: 'UPDATE_TIME', index: 'UPDATE_TIME', align: "center", width: 60},
                    {name: 'type', index: 'type', align: "center", width: 80},
                    {name : 'operate',index : 'operate',align : "center",width : 40,
                        formatter:function(cellvalue, options){
                            return formatterOperate3(options.rowId);
                        }
                    },
                ],
                autowidth: true,
                height: 600,
                rowNum: 21,
                pager: '#property_config_pager',
                rowList: [21, 30, 40],
                gridComplete: function () {
                    $(".view_btn").button();
                    $(".sumbit").button();
                    $(".cancel").button();
                },
                viewrecords: true,
                caption: "环境列表"
            }).jqGrid('navGrid', '#property_config_pager', {
                        edit: false,
                        add: false,
                        del: false,
                        search: false
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
        <!-- 新增按钮。清空筛选按钮 -->
        <table>
            <tr>
                <td><input type='button' id='add_button' class='common_button' value='新增变量' onclick="popAddDialog2( '#addConfigDialogForm','#add_button')" /></td>
                <td><input type='button' class='clean_btn' value='清空筛选' onclick="cleanFilter3()"></td>
            </tr>
        </table>

        <br>

        <!-- 搜索服务 -->
        <form id="property_config_search_form">
            <table cellspacing="5">
                <tr>
                    <td>
                        <label>属性ID</label>
                    </td>
                    <td>
                        <input type="text" name="ID" id="filter_0">
                    </td>
                    <td>
                        <label>属性名称</label>
                    </td>
                    <td>
                        <input type="text" name="PROP_NAME" id="filter_1">
                    </td>
                </tr>

                <tr>
                    <td>
                        <label>属性值</label>
                    </td>
                    <td>
                        <input type="text" name="PROP_VALUE" id="filter_2">
                    </td>
                    <td>
                        <label>描述</label>
                    </td>
                    <td>
                        <input type="text" name="DESC" id="filter_3">
                    </td>
                </tr>

                <tr>
                    <td>
                        <label>状态</label>
                    </td>
                    <td>
                        <select  name="ENABLED" id="filter_4" style="width:172px" onchange="searchClick('#search_btn')">
                            <option value="">全部</option>
                            <option value="Y">启用</option>
                            <option value="N">禁用</option>
                        </select>
                    </td>

                    <td>
                        <label>类型</label>
                    </td>
                    <td>
                        <input type="text" name="type" id="filter_9">
                    </td>

                    <td colspan="2">
                        <a style="height:18px;" href="javascript:;" id='search_btn' onclick="commonSearch('${path}propertyConfig','#property_config_search_form','#property_config_list')">搜索</a>
                    </td>

                </tr>


            </table>
        </form>


        <!-- grid内容展示区域 -->
        <table id="property_config_list"></table>
        <div id="property_config_pager"></div>
    </div>

    <!-- 新增商品对话框UI -->
    <iframe name="bannerImageframe" width="450" height="45" id="bannerImageframe" src="about:blank" frameborder="0" marginwidth="0" scrolling="no">
    </iframe>
    <form id="addConfigDialogForm" method="post" style="display: none;" enctype="multipart/form-data" target="bannerImageframe">

        <div id="content">

        <table cellspacing="0" class="add_form" align="center">

            <tr class="odd-row">
                <th class="first">关键字</th>
                <th>填入值</th>
                <th>关键字</th>
                <th class="last">填入值</th>
            </tr>



            <tr>
                <td class="first"><label>属性名称</label></td>
                <td><input type="text" class="input_text" name="PROP_NAME" maxlength="50" placeholder="仅限50个字符"></td>
                <td><label>属性值</label></td>
                <td class="last"><input class="input_text" type="text" name="PROP_VALUE" maxlength="500" placeholder="仅限500个字符"></td>
            </tr>

            <tr class="odd-row">
                <td class="first"><label>状态</label></td>
                <td>
                    <select class="input_text2"  name="ENABLED" style="width:165px" >
                        <option value="Y">启用</option>
                        <option value="N">禁用</option>
                    </select>
                </td>
                <td><label>类型</label></td>
                <td class="last"><input class="input_text2" type="text" name="type" maxlength="50" placeholder="仅限50个字符"></td>
            </tr>

            <tr>
                <td class="first"><label>描述</label></td>
                <td colspan="3" class="last"><textarea class="input_text" name="DESC" maxlength="200" placeholder="仅限200个字符" rows="3" cols="54"></textarea></td>
            </tr>

            <tr class="odd-row">
                <td class="first"><label>生效时间</label></td>
                <td><input type="text" class="timepicker input_text2"  name="EFFECT_FROM"></td>
                <td><label>失效时间</label></td>
                <td class="last"><input class="timepicker input_text2" type="text"  name="EFFECT_TO"></td>
            </tr>

            <tr>
                <td colspan="2" class="last">
                    <input type='button' class='sumbit' style="width: 100px;" value='提交' onclick="submitAddDialog('${path}propertyConfig','#addConfigDialogForm','#property_config_list')" />
                </td>
                <td colspan="2" class="last">
                    <input type='button' class='cancel' style="width: 100px;" value='取消' onclick="cancelAddDialog('#addConfigDialogForm')" />
                </td>
            </tr>
        </table>
        </div>
    </form>

    <!-- 查看与修改对话框UI -->
    <form id="showConfigDialogForm" method="post" style="display: none;" enctype="multipart/form-data" target="bannerImageframe">
        <table cellspacing="0" class="add_form" align="center">

            <tr class="odd-row">
                <th class="first">关键字</th>
                <th>填入值</th>
                <th>关键字</th>
                <th class="last">填入值</th>
            </tr>

            <tr hidden="true">
                <td><input type="text" id="ID" name="ID"> </td>
            </tr>

            <tr>
                <td class="first"><label>属性名称</label></td>
                <td><input type="text" class="input_text" name="PROP_NAME" id="PROP_NAME" maxlength="50" placeholder="仅限50个字符"></td>
                <td><label>属性值</label></td>
                <td class="last"><input class="input_text" type="text" name="PROP_VALUE" id="PROP_VALUE" maxlength="500" placeholder="仅限500个字符"></td>
            </tr>

            <tr class="odd-row">
                <td class="first"><label>状态</label></td>
                <td>
                    <select class="input_text2"  name="ENABLED" id="ENABLED" style="width:165px" >
                        <option value="Y">启用</option>
                        <option value="N">禁用</option>
                    </select>
                </td>
                <td><label>类型</label></td>
                <td class="last"><input class="input_text2" type="text" name="type" id="type" maxlength="50" placeholder="仅限50个字符"></td>
            </tr>

            <tr>
                <td class="first"><label>描述</label></td>
                <td colspan="3" class="last"><textarea class="input_text" name="DESC" id="DESC" maxlength="200" placeholder="仅限200个字符" rows="3" cols="54"></textarea></td>
            </tr>

            <tr class="odd-row">
                <td class="first"><label>生效时间</label></td>
                <td><input type="text" class="timepicker input_text2"  name="EFFECT_FROM" id="EFFECT_FROM"></td>
                <td><label>失效时间</label></td>
                <td class="last"><input class="timepicker input_text2" type="text"  name="EFFECT_TO" id="EFFECT_TO"></td>
            </tr>

            <tr>
                <td class="first"><label>创建时间</label></td>
                <td><label id="CREATE_TIME"></label></td>
                <td><label>更新时间</label></td>
                <td class="last"><label id="UPDATE_TIME"></label></td>
            </tr>


            <tr>
                <td colspan="2" class="last">
                    <input type='button' class='sumbit' style="width: 100px;" value='提交' onclick="submitModify('${path}propertyConfig','#showConfigDialogForm','#property_config_list')" />
                </td>
                <td colspan="2" class="last">
                    <input type='button' class='cancel' style="width: 100px;" value='取消' onclick="cancelAddDialog('#showConfigDialogForm')" />
                </td>
            </tr>
        </table>
    </form>



</body>
</html>
