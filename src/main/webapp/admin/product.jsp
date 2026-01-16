<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品管理 - 后台管理</title>
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

        .product-table {
            width: 100%;
            border-collapse: collapse;
        }

        .product-table th,
        .product-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .product-table th {
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

        .form-group select {
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
        <div class="section-header">商品管理</div>
        <div class="section-content">
            <div class="action-bar">
                <button class="add-btn" id="addProductBtn">添加商品</button>
                <input type="text" class="search-input" placeholder="搜索商品..." id="searchInput">
            </div>
            <table class="product-table" id="productTable">
                <thead>
                <tr>
                    <th>商品ID</th>
                    <th>商品名称</th>
                    <th>描述</th>
                    <th>价格</th>
                    <th>状态</th>
                    <th>商家ID</th>
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

<!-- 添加/编辑商品模态框 -->
<div id="productModal" class="modal">
    <div class="modal-content">
        <h3 id="modalTitle">添加商品</h3>
        <form id="productForm">
            <input type="hidden" id="productId">
            <div class="form-group">
                <label for="productName">商品名称</label>
                <input type="text" id="productName" required>
            </div>
            <div class="form-group">
                <label for="productDescription">描述</label>
                <textarea id="productDescription"></textarea>
            </div>
            <div class="form-group">
                <label for="productPrice">价格</label>
                <input type="number" id="productPrice" step="0.01" min="0" required>
            </div>
            <div class="form-group">
                <label for="productStatus">状态</label>
                <input type="number" id="productStatus" min="0" max="1" value="1">
            </div>
            <div class="form-group">
                <label for="productMid">商家选择</label>
                <select id="productMid" required>
                    <option value="">请选择商家</option>
                    <!-- 商家列表将通过JavaScript动态生成 -->
                </select>
            </div>
            <div class="modal-actions">
                <button type="button" class="cancel-btn" id="cancelBtn">取消</button>
                <button type="button" class="save-btn" id="saveProductBtn">保存</button>
            </div>
        </form>
    </div>
</div>

<script src="../js/jquery-3.6.1.min.js"></script>
<script>
    // 页面加载初始化
    $(function(){
        queryProducts();  // 查询商品列表
        bindDomEvents();  // 绑定事件
    })

    // 绑定所有DOM事件
    function bindDomEvents(){
        // 添加商品按钮
        $("#addProductBtn").click(function(){
            openAddModal();
        })

        // 保存商品按钮
        $("#saveProductBtn").click(function(){
            saveProduct();
        })

        // 取消按钮
        $("#cancelBtn").click(function(){
            closeModal();
        })

        // 搜索框输入事件
        $("#searchInput").on("input", function(){
            searchProducts($(this).val());
        })

        // 点击模态框外部关闭
        $(window).click(function(event){
            if($(event.target).is("#productModal")){
                closeModal();
            }
        })
    }

    // 查询商品列表
    function queryProducts(){
        $.ajax({
            type: "GET",
            url: "/product",
            data: {
                action: 'all',
            },
            dataType: "json",
            success: function(products){
                renderProducts(products);
            },
            error: function(){
                $("#productTable tbody").html('<tr><td colspan="7" style="text-align: center; padding: 20px; color: #999;">加载失败，请刷新重试</td></tr>');
            }
        });
    }

    // 搜索商品
    function searchProducts(keyword){
        $.ajax({
            type: "GET",
            url: "/search",
            data: {
                keyword: keyword,
                action: 'product'
            },
            dataType: "json",
            success: function(products){
                renderProducts(products);
            }
        });
    }

    // 渲染商品列表
    function renderProducts(products){
        let tbody = $("#productTable tbody");
        tbody.empty();

        if(products.length === 0){
            tbody.html('<tr><td colspan="7" style="text-align: center; padding: 20px; color: #999;">暂无商品数据</td></tr>');
            return;
        }

        for(let i=0; i<products.length; i++){
            let product = products[i];
            let statusText = product.productstatus == 1 ? '启用' : '禁用';

            tbody.append(
                '<tr>' +
                '<td>' + product.productid + '</td>' +
                '<td>' + product.productname + '</td>' +
                '<td>' + product.description + '</td>' +
                '<td>¥' + product.price + '</td>' +
                '<td>' + statusText + '</td>' +
                '<td>' + product.mid + '</td>' +
                '<td>' +
                '<div class="action-buttons">' +
                '<button class="edit-btn" onclick="openEditModal(' + product.productid + ', \'' + product.productname + '\', \'' + product.description + '\', ' + product.price + ', ' + product.productstatus + ', ' + product.mid + ')">编辑</button>' +
                '<button class="delete-btn" onclick="deleteProduct(' + product.productid + ')">删除</button>' +
                '</div>' +
                '</td>' +
                '</tr>'
            );
        }
    }

    // 加载商家列表到下拉框
    function loadMerchants(){
        return new Promise(function(resolve){
            $.ajax({
                type: "GET",
                url: "/index",
                data: {
                    action: 'all',
                },
                dataType: "json",
                success: function(merchants){
                    let merchantSelect = $("#productMid");
                    merchantSelect.empty();
                    merchantSelect.append('<option value="">请选择商家</option>');

                    for(let i=0; i<merchants.length; i++){
                        let merchant = merchants[i];
                        merchantSelect.append('<option value="' + merchant.mid + '">' + merchant.mname + '</option>');
                    }
                    resolve();
                },
                error: function(){
                    $("#productMid").html('<option value="">加载失败</option>');
                    resolve();
                }
            });
        });
    }

    // 打开添加商品模态框
    function openAddModal(){
        $("#modalTitle").text('添加商品');
        $("#productId").val('');
        $("#productName").val('');
        $("#productDescription").val('');
        $("#productPrice").val('');
        $("#productStatus").val('1');

        // 加载商家列表
        loadMerchants().then(function(){
            $("#productModal").show();
        });
    }

    // 打开编辑商品模态框
    function openEditModal(id, name, description, price, status, mid){
        $("#modalTitle").text('编辑商品');
        $("#productId").val(id);
        $("#productName").val(name);
        $("#productDescription").val(description);
        $("#productPrice").val(price);
        $("#productStatus").val(status);

        // 加载商家列表并设置当前商家
        loadMerchants().then(function(){
            $("#productMid").val(mid);
            $("#productModal").show();
        });
    }

    // 关闭模态框
    function closeModal(){
        $("#productModal").hide();
    }

    // 保存商品
    function saveProduct(){
        let id = $("#productId").val();
        let name = $("#productName").val();
        let description = $("#productDescription").val();
        let price = $("#productPrice").val();
        let status = $("#productStatus").val();
        let mid = $("#productMid").val();

        // 数据验证
        if(!name){
            alert('请填写商品名称');
            return;
        }

        if(!price || price <= 0){
            alert('请填写正确的价格');
            return;
        }

        if(!mid){
            alert('请选择商家');
            return;
        }

        let url = '/product';
        let method = 'POST';
        let productData = {
            productname: name,
            description: description,
            price: parseFloat(price),
            productstatus: parseInt(status),
            mid: parseInt(mid)
        };

        if (id) {
            method = 'PUT';
            productData.productid = parseInt(id);
        }

        $.ajax({
            type: method,
            url: url,
            contentType: "application/json",
            data: JSON.stringify(productData),
            dataType: "json",
            success: function(response){
                if(response.success){
                    alert(response.message);
                    closeModal();
                    queryProducts();
                } else {
                    alert('操作失败: ' + response.message);
                }
            },
            error: function(){
                alert('保存失败，请刷新重试');
            }
        });
    }

    // 删除商品
    function deleteProduct(id){
        if (!confirm('确定要删除这个商品吗？')) {
            return;
        }

        $.ajax({
            type: "DELETE",
            url: "/product",
            data: {
                productid: id
            },
            dataType: "json",
            success: function(response){
                if(response.success){
                    alert(response.message);
                    queryProducts();
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