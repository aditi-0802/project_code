<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>

<%
   File file ;
   int maxFileSize = 10000 * 1024;
   int maxMemSize = 10000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = "c:/Users/Aditi/Documents/NetBeansProjects/abc/web/pics/";
   String comp_id="";
   String latitude="";
   String longitude="";
   String desc="";
    String ext ="";
   // Verify the content type
   String contentType = request.getContentType();
   Connection conn=dao.database.getConnection();
   PreparedStatement ps=conn.prepareStatement("select nvl(max(comp_id)+1,'1000001') from complaints");
   ResultSet rs=ps.executeQuery();
   if(rs.next())
       comp_id=rs.getString(1);
   else
       comp_id="1000001";
  // out.println(comp_id);
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:/Users/Aditi/Documents/NetBeansProjects/pics/"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      
      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");
         String a[]=new String[7];
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () ) {
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               String fileName = fi.getName();
             //  out.println(fileName);
                  a=fileName.split("\\.",0);
                  //out.println(a[0]);
            for(int j=0;j<7;j++)
            {//out.println(a[j]);
                
            }
            ext = a[1];
               fileName = comp_id+"."+ext;
              // out.println(fileName);
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();
          //  out.println(fieldName);
          //  out.println(fileName);
               // Write the file
               if( fileName.lastIndexOf("\\") >= 0 ) {
                  file = new File( filePath + 
                  fileName.substring( fileName.lastIndexOf("\\"))) ;
                  
                  out.println(filePath + 
                  fileName.substring( fileName.lastIndexOf("\\")));
               } else {
                  file = new File( filePath + 
                  fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                 // out.println("11");
                 /* out.println(filePath + 
                  fileName.substring(fileName.lastIndexOf("\\")+1));*/
               }
               fi.write( file ) ;
             //  out.println("Uploaded Filename: " + filePath + fileName + "<br>");
            }
            else
            {
                String fieldName = fi.getFieldName();
                String value=fi.getString();
             //   out.println(fieldName);
              //  out.println(value);
                if(fieldName.equalsIgnoreCase("latitude"))
                    latitude = value;
                 if(fieldName.equalsIgnoreCase("longitude"))
                    longitude = value;
                 if(fieldName.equalsIgnoreCase("desc"))
                    desc = value;
                
            }
         }
       //  String latitude=request.getParameter("latitude");
         //out.println(latitude);
        // out.println(latitude+"--"+longitude+"--"+desc);
         ps = conn.prepareStatement("insert into complaints(comp_id,latitude,longitude,description,created_on,extension) values(?,?,?,?,sysdate,?)");
         ps.setString(1, comp_id);
         ps.setString(2, latitude);
         ps.setString(3, longitude);
         ps.setString(4, desc);
           ps.setString(5, ext);
       
         ps.executeUpdate();
         
         out.println("<div style='padding:5%;margin:5%;background-color:#f0f0f0;font-size:250%'><center><b><font color='brown'>Complaint saves successfully with ID :"+comp_id+"</font></b><br><br><a href='view_details.jsp?comp_id="+comp_id+"' style='display:block;background-color:green;padding:2%;width:50%;margin:auto;text-decoration:none;color:white'>View Details</a></center></div>");
         out.println("</body>");
         out.println("</html>");
      } catch(Exception ex) {
         System.out.println(ex);
         out.println(ex.getMessage());
      }
   } else {
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>
