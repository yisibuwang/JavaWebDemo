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
                    <button class="add-btn" onclick="openAddModal()">添加商品</button>
                    <input type="text" class="search-input" placeholder="搜索商品...">
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
                        <!-- 商品数据将通过JavaScript动态生成 -->
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
                        <!-- 商家列表将通过JavaScript动态生成 -->
                    </select>
                </div>
                <div class="modal-actions">
                    <button type="button" class="cancel-btn" onclick="closeModal()">取消</button>
                    <button type="button" class="save-btn" onclick="saveProduct()">保存</button>
                </div>
            </form>
        </div>
    </div>

    <script src="../js/jquery-3.6.1.min.js"></script>
    <script>
        // 加载商品列表
        async function loadProducts() {
            try {
                const response = await fetch('/api/product');
                const products = await response.json();
                
                const tbody = document.querySelector('#productTable tbody');
                tbody.innerHTML = '';
                
                products.forEach(product => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${product.productid}</td>
                        <td>${product.productname}</td>
                        <td>${product.description}</td>
                        <td>¥${product.price}</td>
                        <td>${product.productstatus == 1 ? '启用' : '禁用'}</td>
                        <td>${product.mid}</td>
                        <td>
                            <div class="action-buttons">
                                <button class="edit-btn" onclick="openEditModal(${product.productid}, '${product.productname}', '${product.description}', ${product.price}, ${product.productstatus}, ${product.mid})">编辑</button>
                                <button class="delete-btn" onclick="deleteProduct(${product.productid})">删除</button>
                            </div>
                        </td>
                    `;
                    tbody.appendChild(row);
                });
            } catch (error) {
                console.error('加载商品失败:', error);
            }
        }

        // 加载商家列表到下拉框
        async function loadMerchants() {
            try {
                const response = await fetch('/api/merchant');
                const merchants = await response.json();
                
                const merchantSelect = document.getElementById('productMid');
                merchantSelect.innerHTML = '';
                
                if (merchants.length === 0) {
                    merchantSelect.innerHTML = '<option value="">暂无商家</option>';
                    return;
                }
                
                merchants.forEach(merchant => {
                    const option = document.createElement('option');
                    option.value = merchant.mid;
                    option.textContent = merchant.mname;
                    merchantSelect.appendChild(option);
                });
            } catch (error) {
                console.error('加载商家列表失败:', error);
                document.getElementById('productMid').innerHTML = '<option value="">加载失败</option>';
            }
        }

        // 打开添加商品模态框
        async function openAddModal() {
            document.getElementById('modalTitle').textContent = '添加商品';
            document.getElementById('productId').value = '';
            document.getElementById('productName').value = '';
            document.getElementById('productDescription').value = '';
            document.getElementById('productPrice').value = '';
            document.getElementById('productStatus').value = '1';
            
            // 加载商家列表
            await loadMerchants();
            
            document.getElementById('productModal').style.display = 'block';
        }

        // 打开编辑商品模态框
        async function openEditModal(id, name, description, price, status, mid) {
            document.getElementById('modalTitle').textContent = '编辑商品';
            document.getElementById('productId').value = id;
            document.getElementById('productName').value = name;
            document.getElementById('productDescription').value = description;
            document.getElementById('productPrice').value = price;
            document.getElementById('productStatus').value = status;
            
            // 加载商家列表并设置当前商家
            await loadMerchants();
            document.getElementById('productMid').value = mid;
            
            document.getElementById('productModal').style.display = 'block';
        }

        // 关闭模态框
        function closeModal() {
            document.getElementById('productModal').style.display = 'none';
        }

        // 保存商品
        async function saveProduct() {
            const id = document.getElementById('productId').value;
            const name = document.getElementById('productName').value;
            const description = document.getElementById('productDescription').value;
            const price = document.getElementById('productPrice').value;
            const status = document.getElementById('productStatus').value;
            const mid = document.getElementById('productMid').value;
            
            // 这里可以添加保存商品的API调用
            alert('商品保存成功');
            closeModal();
            loadProducts();
        }

        // 删除商品
        async function deleteProduct(id) {
            if (confirm('确定要删除这个商品吗？')) {
                // 这里可以添加删除商品的API调用
                alert('商品删除成功');
                loadProducts();
            }
        }

        // 关闭模态框（点击外部区域）
        window.onclick = function(event) {
            const modal = document.getElementById('productModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }

        // 初始化加载
        document.addEventListener('DOMContentLoaded', function() {
            loadProducts();
        });
    </script>
</body>
</html>
