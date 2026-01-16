<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商家管理 - 后台管理</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }

        .header {
            background-color: #333;
            padding: 15px 0;
            color: white;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            font-size: 20px;
            font-weight: bold;
        }

        .nav {
            display: flex;
            gap: 30px;
        }

        .nav-item {
            cursor: pointer;
        }

        .main-content {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }

        .admin-section {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .section-header {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            font-weight: 600;
            font-size: 18px;
        }

        .section-content {
            padding: 20px;
        }

        .action-bar {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .add-btn {
            background: #52c41a;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
        }

        .search-input {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 300px;
        }

        .merchant-table {
            width: 100%;
            border-collapse: collapse;
        }

        .merchant-table th,
        .merchant-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .merchant-table th {
            background-color: #fafafa;
            font-weight: 600;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .edit-btn {
            background: #1890ff;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .delete-btn {
            background: #ff4d4f;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 8px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .modal-actions {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .save-btn {
            background: #52c41a;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }

        .cancel-btn {
            background: #999;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }

        .loading {
            text-align: center;
            padding: 20px;
            color: #999;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="header-content">
        <div class="logo">后台管理系统</div>
        <div class="nav">
            <div class="nav-item" onclick="location.href='product.jsp'">商品管理</div>
            <div class="nav-item" onclick="location.href='merchant.jsp'">商家管理</div>
            <div class="nav-item" onclick="location.href='../index.jsp'">返回前台</div>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="admin-section">
        <div class="section-header">商家管理</div>
        <div class="section-content">
            <div class="action-bar">
                <button class="add-btn" id="addMerchantBtn">添加商家</button>
                <input type="text" class="search-input" placeholder="搜索商家..." id="searchInput">
            </div>
            <div id="merchantTableContainer">
                <table class="merchant-table" id="merchantTable">
                    <thead>
                    <tr>
                        <th>商家ID</th>
                        <th>商家名称</th>
                        <th>联系电话</th>
                        <th>地址</th>
                        <th>评分</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td colspan="7" class="loading">加载中...</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- 添加/编辑商家模态框 -->
<div id="merchantModal" class="modal">
    <div class="modal-content">
        <h3 id="modalTitle">添加商家</h3>
        <form id="merchantForm">
            <input type="hidden" id="merchantId">
            <div class="form-group">
                <label for="merchantName">商家名称</label>
                <input type="text" id="merchantName" required>
            </div>
            <div class="form-group">
                <label for="merchantPhone">联系电话</label>
                <input type="text" id="merchantPhone" required>
            </div>
            <div class="form-group">
                <label for="merchantAddress">地址</label>
                <input type="text" id="merchantAddress" required>
            </div>
            <div class="form-group">
                <label for="merchantScore">评分</label>
                <input type="text" id="merchantScore" value="0">
            </div>
            <div class="form-group">
                <label for="merchantStatus">状态</label>
                <input type="number" id="merchantStatus" min="0" max="1" value="1">
            </div>
            <div class="modal-actions">
                <button type="button" class="cancel-btn" id="cancelBtn">取消</button>
                <button type="button" class="save-btn" id="saveMerchantBtn">保存</button>
            </div>
        </form>
    </div>
</div>

<script src="../js/jquery-3.6.1.min.js"></script>
<script>
    // 页面加载初始化
    $(function(){
        queryMerchants();  // 查询商家列表
        bindDomEvents();   // 绑定事件
    })

    // 绑定所有DOM事件
    function bindDomEvents(){
        // 添加商家按钮
        $("#addMerchantBtn").click(function(){
            openAddModal();
        })

        // 保存商家按钮
        $("#saveMerchantBtn").click(function(){
            saveMerchant();
        })

        // 取消按钮
        $("#cancelBtn").click(function(){
            closeModal();
        })

        // 搜索框输入事件
        $("#searchInput").on("input", function(){
            searchMerchants($(this).val());
        })

        // 点击模态框外部关闭
        $(window).click(function(event){
            if($(event.target).is("#merchantModal")){
                closeModal();
            }
        })
    }

    // 查询商家列表
    function queryMerchants(){
        $.ajax({
            type: "GET",
            url: "/index",
            data: {
                action: 'all',
            },
            dataType: "json",
            success: function(merchants){
                renderMerchants(merchants);
            },
            error: function(){
                $("#merchantTable tbody").html('<tr><td colspan="7" style="text-align: center; padding: 20px; color: #999;">加载失败，请刷新重试</td></tr>');
            }
        });
    }

    // 搜索商家
    function searchMerchants(keyword){
        $.ajax({
            type: "GET",
            url: "/search",
            data: {
                keyword: keyword,
                action: 'merchant'
            },
            dataType: "json",
            success: function(merchants){
                renderMerchants(merchants);
            }
        });
    }

    // 渲染商家列表
    function renderMerchants(merchants){
        let tbody = $("#merchantTable tbody");
        tbody.empty();

        if(merchants.length === 0){
            tbody.html('<tr><td colspan="7" style="text-align: center; padding: 20px; color: #999;">暂无商家数据</td></tr>');
            return;
        }

        for(let i=0; i<merchants.length; i++){
            let merchant = merchants[i];
            let statusText = merchant.status == 1 ? '启用' : '禁用';

            tbody.append(
                '<tr>' +
                '<td>' + merchant.mid + '</td>' +
                '<td>' + merchant.mname + '</td>' +
                '<td>' + merchant.phone + '</td>' +
                '<td>' + merchant.address + '</td>' +
                '<td>' + merchant.score + '</td>' +
                '<td>' + statusText + '</td>' +
                '<td>' +
                '<div class="action-buttons">' +
                '<button class="edit-btn" onclick="openEditModal(' + merchant.mid + ', \'' + merchant.mname + '\', \'' + merchant.phone + '\', \'' + merchant.address + '\', \'' + merchant.score + '\', ' + merchant.status + ')">编辑</button>' +
                '<button class="delete-btn" onclick="deleteMerchant(' + merchant.mid + ')">删除</button>' +
                '</div>' +
                '</td>' +
                '</tr>'
            );
        }
    }

    // 打开添加商家模态框
    function openAddModal(){
        $("#modalTitle").text('添加商家');
        $("#merchantId").val('');
        $("#merchantName").val('');
        $("#merchantPhone").val('');
        $("#merchantAddress").val('');
        $("#merchantScore").val('0');
        $("#merchantStatus").val('1');
        $("#merchantModal").show();
    }

    // 打开编辑商家模态框
    function openEditModal(id, name, phone, address, score, status){
        $("#modalTitle").text('编辑商家');
        $("#merchantId").val(id);
        $("#merchantName").val(name);
        $("#merchantPhone").val(phone);
        $("#merchantAddress").val(address);
        $("#merchantScore").val(score);
        $("#merchantStatus").val(status);
        $("#merchantModal").show();
    }

    // 关闭模态框
    function closeModal(){
        $("#merchantModal").hide();
    }

    // 保存商家
    function saveMerchant(){
        let id = $("#merchantId").val();
        let name = $("#merchantName").val();
        let phone = $("#merchantPhone").val();
        let address = $("#merchantAddress").val();
        let score = $("#merchantScore").val();
        let status = $("#merchantStatus").val();

        // 数据验证
        if(!name || !phone || !address){
            alert('请填写完整信息');
            return;
        }

        let url = '/index';
        let method = 'POST';
        let merchantData = {
            mname: name,
            phone: phone,
            address: address,
            score: score,
            status: parseInt(status)
        };

        if (id) {
            method = 'PUT';
            merchantData.mid = parseInt(id);
        }

        $.ajax({
            type: method,
            url: url,
            contentType: "application/json",
            data: JSON.stringify(merchantData),
            dataType: "json",
            success: function(response){
                if(response.success){
                    alert(response.message);
                    closeModal();
                    queryMerchants();
                } else {
                    alert('操作失败: ' + response.message);
                }
            },
            error: function(){
                alert('保存失败，请刷新重试');
            }
        });
    }

    // 删除商家
    function deleteMerchant(id){
        if (!confirm('确定要删除这个商家吗？')) {
            return;
        }

        $.ajax({
            type: "DELETE",
            url: "/index",
            data: {
                mid: id
            },
            dataType: "json",
            success: function(response){
                if(response.success){
                    alert(response.message);
                    queryMerchants();
                } else {
                    alert('删除失败: ' + response.message);
                }
            },
            error: function(){
                alert('删除失败，请刷新重试');
            }
        });
    }
</script>
</body>
</html>