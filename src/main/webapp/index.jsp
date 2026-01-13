<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <title>学生管理系统</title>
      <style>
          table{
              border: 1px solid black;
          }
          td{
              border: 1px solid black;
              width: 200px;
              text-align: center;
          }
      </style>
  </head>
  <body>
      <h3>学生信息表 <input type="button" id="deleteBtn" name="deleteBtn" value="删除" style="margin-left: 15px;"/></h3>
      <table id="stuTable"></table>
      <h3 style="margin-top: 30px;">添加学生</h3>
      <form>
        <table>
            <tr>
              <td>姓名：</td>
              <td><input type="text" id="sname_add" name="sname_add"/></td>
            </tr>
            <tr>
              <td>生日：</td>
              <td><input type="date" id="sbirth_add" name="sbirth_add"/></td>
            </tr>
            <tr>
              <td>班级：</td>
              <td><input type="text" id="sclass_add" name="sclass_add"/></td>
            </tr>
            <tr>
                <td colspan="2">
                  <input type="button" id="addBtn" name="addBtn" value="添加">
                </td>
           </tr>
        </table>
      </form>

      <h3 style="margin-top: 30px;">修改学生</h3>
      <form>
          <table>
              <tr>
                  <td>学号：</td>
                  <td><input type="text" id="sno_edit" name="sno_edit" readonly="readonly"/></td>
              </tr>
              <tr>
                  <td>姓名：</td>
                  <td><input type="text" id="sname_edit" name="sname_edit"/></td>
              </tr>
              <tr>
                  <td>生日：</td>
                  <td><input type="date" id="sbirth_edit" name="sbirth_edit"/></td>
              </tr>
              <tr>
                  <td>班级：</td>
                  <td><input type="text" id="sclass_edit" name="sclass_edit"/></td>
              </tr>
              <tr>
                  <td colspan="2">
                      <input type="button" id="editBtn" name="editBtn" value="修改">
                  </td>
              </tr>
          </table>
      </form>
    <script src="js/jquery-3.6.1.min.js"></script>
    <script>
        /*
            POST（添加）
            GET（查询）
            DELETE（删除）
            PUT（修改）
         */
        $(function(){
            queryStudent();
            bindDom();
        })

        function bindDom(){
            $("#addBtn").click(function(){
                addStudent();
            })

            $("#editBtn").click(function(){
                editStudent();
            })

            $("#deleteBtn").click(function(){
                deleteStudent();
            })
        }

        function deleteStudent(){
            let snos = "";
            $("#stuTable").find(":checkbox:not(#allCheck):checked").each(function(){
                snos += $(this).attr("sno") + ","
            })
            //去最后一个逗号
            if(snos.length>0){
                snos = snos.substring(0, snos.length-1);
            }

            $.ajax({
                type: "DELETE",
                url: "/student",
                data:{
                    snos : snos
                },
                dataType: "json",
                success: function (msg) {
                    if(msg.isok == "yes"){
                        alert("删除成功");
                        queryStudent();
                    }else{
                        alert("删除失败");
                    }
                }
            })
        }

        function editStudent(){
            $.ajax({
                type: "PUT",
                url: "/student",
                data:{
                    sno_edit : $("#sno_edit").val(),
                    sname_edit : $("#sname_edit").val(),
                    sbirth_edit : $("#sbirth_edit").val(),
                    sclass_edit : $("#sclass_edit").val()
                },
                dataType: "json",
                success: function (msg) {
                    if(msg.isok == "yes"){
                        alert("修改成功");
                        queryStudent();
                    }else{
                        alert("修改失败");
                    }
                }
            })
        }


        function addStudent(){
            $.ajax({
                type: "POST",
                url: "/student",
                data:{
                    sname_add : $("#sname_add").val(),
                    sbirth_add : $("#sbirth_add").val(),
                    sclass_add : $("#sclass_add").val()
                },
                dataType: "json",
                success: function (msg) {
                    if(msg.isok == "yes"){
                        alert("添加成功");
                        queryStudent();
                    }else{
                        alert("添加失败");
                    }
                }
            })
        }


        function queryStudent(){
            $.ajax({
                type: "GET",
                url: "/student",
                dataType: "json",
                success: function(students){
                    $("#stuTable").empty();
                    //表头
                    $("#stuTable").append(
                        "<tr>" +
                            "<td><input type='checkbox' id='allCheck' name='allCheck'></input></td>"+
                            "<td>学号</td>"+
                            "<td>姓名</td>"+
                            "<td>生日</td>"+
                            "<td>班级</td>"+
                        "</tr>"
                    )
                    //表体
                    for(let i=0; i<students.length;i++){
                        let s = students[i];
                        s.sbirth = dateFormat('YYYY-mm-dd', new Date(s.sbirth))
                        $("#stuTable").append(
                            "<tr>" +
                              "<td><input type='checkbox' sno="+s.sno+"></input></td>" +
                              "<td>"+ s.sno +"</td>"+
                              "<td>"+ s.sname +"</td>"+
                              "<td>"+ s.sbirth +"</td>"+
                              "<td>"+ s.sclass +"</td>"+
                            "</tr>"
                        )
                    }

                    bindCheckbox();
                }
            });
        }

        function dateFormat(fmt, date) {
            let ret;
            const opt = {
                "Y+": date.getFullYear().toString(),        // 年
                "m+": (date.getMonth() + 1).toString(),     // 月
                "d+": date.getDate().toString(),            // 日
                "H+": date.getHours().toString(),           // 时
                "M+": date.getMinutes().toString(),         // 分
                "S+": date.getSeconds().toString()          // 秒
                // 有其他格式化字符需求可以继续添加，必须转化成字符串
            };
            for (let k in opt) {
                ret = new RegExp("(" + k + ")").exec(fmt);
                if (ret) {
                    fmt = fmt.replace(ret[1], (ret[1].length == 1) ? (opt[k]) : (opt[k].padStart(ret[1].length, "0")))
                };
            };
            return fmt;
        }
        function bindCheckbox(){
            //全选checkbox
            $("#allCheck").on("click", function (){
                $(this).parents().find(":checkbox").prop("checked",$(this).prop("checked"));
            });

            //非全选的其他checkbox
            $("#stuTable").on("click", ":checkbox:not(#allCheck)",function(){
                let allCheck = true;
                $("#stuTable :checkbox:not(#allCheck)").each(function(){
                    if(!$(this).prop("checked")){
                        allCheck = false;
                        return false;
                    }
                })
                $("#allCheck").prop("checked",allCheck);
                if($(this).prop("checked")) {
                    fillEditTable($(this));
                }
            })
        }

        function fillEditTable($this){
            $tr = $this.parentsUntil("table")
            $("#sno_edit").val($tr.find("td:nth-child(2)").text());
            $("#sname_edit").val($tr.find("td:nth-child(3)").text());
            $("#sbirth_edit").val($tr.find("td:nth-child(4)").text());
            $("#sclass_edit").val($tr.find("td:nth-child(5)").text());
        }

    </script>
  </body>
</html>