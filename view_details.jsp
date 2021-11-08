<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <%@include file="header_include.jsp" %>
</head>

<body id="page-top" >

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
         <%@include file="sidemenu.jsp" %>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                    <%@include file="topmenu.jsp" %>
     
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                   
                    <!-- Content Row -->
                    <div class="row">
                        <div class="col-lg-12">
                     <%
                     String comp_id=request.getParameter("comp_id");
                     Connection conn=dao.database.getConnection();
                     PreparedStatement ps=conn.prepareStatement("select latitude,longitude,description,extension from complaints where comp_id=? ");
                     ps.setString(1, comp_id);
                     ResultSet rs=ps.executeQuery();
                     String latitude="";
                     String longitude="";
                     String description="";
                     String extension="";
                     while(rs.next()){
                     latitude = rs.getString(1);
                     longitude = rs.getString(2);
                     description = rs.getString(3);
                     extension = rs.getString(4);
                     
                     }
                     %>  
                     
                     <p class="btn btn-info"> Complaint ID : <%=comp_id%></P>
                     <p><%=description%></p>
                     <img cladd="img img-responsive" src="pics/<%=comp_id%>.<%=extension%>" style="width:100%"/>
      
<iframe 
  width="100%" 
  height="500" 
  frameborder="0" 
  scrolling="no" 
  marginheight="0" 
  marginwidth="0" 
  src='https://maps.google.com/maps?q=<%=latitude%>,<%=longitude%>&Roadmap&z=14&ie=UTF8&iwloc=&output=embed' id="mapframe"
  class="iframe iframe-responsive"
 >
 </iframe>

                            
                        </div>

                    </div>

                    <!-- Content Row -->

                    
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@include file="footer.jsp" %>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <%@include file="footer_include.jsp" %>
</body>

</html>
