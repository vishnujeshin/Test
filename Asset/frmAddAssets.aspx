<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAddAssets.aspx.cs" Inherits="AssetMobileApplication.Asset.frmAddAssets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        function pageLoad() {
            $(function () {
                SetDefaultDate($("#<%= txtDateAcquired.ClientID %>"), $("#<%= txtStatrtDate.ClientID %>"), $("#<%= txtEndDate.ClientID %>"));
            });
            $("select").chosen({ width: '100%' });

            $('#<%=ddlLocation.ClientID %>').chosen({ width: '100%' });
            $('#<%=ddlLocation.ClientID %>').trigger("liszt:updated");
            $('#<%=ddlSelectAMClevel.ClientID %>').chosen({ width: '100%' });
            $('#<%=ddlSelectAMClevel.ClientID %>').trigger("liszt:updated");
            $('#<%=ddlCategory.ClientID %>').chosen({ width: '100%' });
            $('#<%=ddlCategory.ClientID %>').trigger("liszt:updated");
            $('#<%=ddlBrand.ClientID %>').chosen({ width: '100%' });
            $('#<%=ddlBrand.ClientID %>').trigger("liszt:updated");
            $('#<%=ddlClass.ClientID %>').chosen({ width: '100%' });
            $('#<%=ddlClass.ClientID %>').trigger("liszt:updated");
            $('#<%=ddlDepartment.ClientID %>').chosen({ width: '100%' });
            $('#<%=ddlDepartment.ClientID %>').trigger("liszt:updated");
            $('#<%=ddlEmployee.ClientID %>').chosen({ width: '100%' });
            $('#<%=ddlEmployee.ClientID %>').trigger("liszt:updated");
            $('#<%=ddlMethod.ClientID %>').chosen({ width: '100%' });
            $('#<%=ddlMethod.ClientID %>').trigger("liszt:updated");
            $('#<%=ddlSubCategory.ClientID %>').chosen({ width: '100%' });
            $('#<%=ddlSubCategory.ClientID %>').trigger("liszt:updated");
            $('#<%=ddlVendor.ClientID %>').chosen({ width: '100%' });
            $('#<%=ddlVendor.ClientID %>').trigger("liszt:updated");

            $('#<%=txtSalvageValue.ClientID %>').focusout(function () {

                var TotalCost = $("#<%=txtTotalCost.ClientID%>").val();
                var UsefulLife = $("#<%=txtUsefulLife.ClientID%>").val();
                var Salvage = $("#<%=txtSalvageValue.ClientID%>").val();
                var Method = $("#<%=ddlMethod.ClientID%>").val();

                var status = true;
                if ($("#<%=txtTotalCost.ClientID%>").val() == '') {
                    ShowPopupMessageBox('Please Enter Total cost');
                    status = false;
                }

                else if ($("#<%=txtUsefulLife.ClientID%>").val() == '') {
                    ShowPopupMessageBox('Please Enter Useful Life');
                    status = false;
                }

                else if ($("#<%=txtSalvageValue.ClientID%>").val() == '') {
                    ShowPopupMessageBox('Please Enter Salvage value');
                    status = false;

                }

                if (TotalCost != '' && UsefulLife != '' && Salvage != '') {
                    if ($("#<%=ddlMethod.ClientID%>").val() == "Straight Line Method") {
                        var Depreciation = parseFloat((((TotalCost - Salvage) / UsefulLife) / TotalCost) * 100).toFixed(2)
                        $("#<%=txtRateofDepreciation.ClientID%>").val(Depreciation + '%');
                    }

                    else if ($("#<%=ddlMethod.ClientID%>").val() == "Written Down Value Method") {
                        var Depreciation = parseFloat((1 - (UsefulLife * Math.sqrt(Salvage / TotalCost))) / 100).toFixed(2)
                        $("#<%=txtRateofDepreciation.ClientID%>").val(Depreciation);
                    }
                    else {
                        ($("[id*='ddlMethod'] :selected").text() == '--Select--')
                        ShowPopupMessageBox('Please Select the Any Method');
                        status = false;
                    }

                }

                return status;
            });

            $('#<%=pdfpreview1.ClientID %>').change(function () {
                fncFileValidation1();
            })

            $('#<%=pdfpreview2.ClientID %>').change(function () {
                fncFileValidation2();
            })
            $('#<%=pdfpreview3.ClientID %>').change(function () {
                fncFileValidation3();
            })
            $('#<%=pdfpreview4.ClientID %>').change(function () {
                fncFileValidation4();
            })
            $('#<%=pdfpreview5.ClientID %>').change(function () {
                fncFileValidation5();
            })
        }
        function SetDefaultDate(DateAcquired, StatrtDate, EndDate) {
            try {
                DateAcquired.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                StatrtDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                EndDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                if (DateAcquired.val() === '') {
                    DateAcquired.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "");
                }
                if (StatrtDate.val() === '') {
                    StatrtDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "");
                }
                if (EndDate.val() === '') {
                    EndDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "");
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    //$('#blah')
                    //    .attr('src', e.target.result)
                    //    .width(150)
                    //    .height(100);
                    $('#<%=imgpreview.ClientID %>').attr('src', e.target.result);
                };

                reader.readAsDataURL(input.files[0]);
            }
        }
        function showpreview(input) {
            try {
                var maxsize = 1000 * 1024;
                if (input.files && input.files[0].size < maxsize) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=imgpreview.ClientID %>').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
                else {
                    input.value = "";
                    ShowToastError('File size exceeds 30 kb');
                    //alert('file size: ' + input.files[0].size);
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }

        function showpreview1(input) {
            try {
                fncFileValidation1(input);
                var maxsize = 2000 * 1024;
                if (input.files && input.files[0].size < maxsize) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=pdfpreview1.ClientID %>').attr('src', e.target.result);
                     }
                     reader.readAsDataURL(input.files[0])
                 }
                 else {
                     input.value = "";
                     ShowToastError('File size exceeds 2 MB');
                     //alert('file size: ' + input.files[0].size);
                 }
             }
             catch (err) {
                 ShowToastError(err.message);
             }
        }

        function fncFileValidation1(input) {

           $('#<%=pdfpreview1.ClientID %>').on('change', function (e) {
                e.preventDefault();

                // Get the selected file
               var selectedFile = input.files[0];

                 // Check if a file is selected
                 if (selectedFile) {
                     // Check the file extension
                     var fileExtension = selectedFile.name.split('.').pop().toLowerCase();

                     if (fileExtension === 'xlsx' || fileExtension === 'pdf') {
                         // Valid file type
                         // You can proceed with form submission or any other action
                         //ShowToastError('Valid file selected: ' + selectedFile.name);
                         // Uncomment the line below to submit the form
                         // $('#fileForm').submit();
                     } else {
                         // Invalid file type
                         input.value = "";
                         ShowToastError('Invalid file type. Please select an XLSX or PDF file.');
                     }
                 } else {
                     // No file selected
                     ShowToastError('No file selected.');
                 }
             });
        }

        function showpreview2(input) {
            try {
                fncFileValidation2(input);
                var maxsize = 2000 * 1024;
                if (input.files && input.files[0].size < maxsize) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=pdfpreview2.ClientID %>').attr('src', e.target.result);
                           }
                           reader.readAsDataURL(input.files[0])
                       }
                       else {
                           input.value = "";
                           ShowToastError('File size exceeds 2 MB');
                           //alert('file size: ' + input.files[0].size);
                       }
                   }
                   catch (err) {
                       ShowToastError(err.message);
                   }
        }


        function fncFileValidation2(input) {

            $('#<%=pdfpreview2.ClientID %>').on('change', function (e) {
                e.preventDefault();

                // Get the selected file
                var selectedFile = input.files[0];

                // Check if a file is selected
                if (selectedFile) {
                    // Check the file extension
                    var fileExtension = selectedFile.name.split('.').pop().toLowerCase();

                    if (fileExtension === 'xlsx' || fileExtension === 'pdf') {
                        // Valid file type
                        // You can proceed with form submission or any other action
                       // ShowToastError('Valid file selected: ' + selectedFile.name);
                        // Uncomment the line below to submit the form
                        // $('#fileForm').submit();
                    } else {
                        input.value = "";
                        ShowToastError('Invalid file type. Please select an XLSX or PDF file.');
                    }
                } else {
                    // No file selected
                    ShowToastError('No file selected.');
                }
            });
        }
        function showpreview3(input) {
            try {
                fncFileValidation3(input);
                var maxsize = 2000 * 1024;
                if (input.files && input.files[0].size < maxsize) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=pdfpreview3.ClientID %>').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0])
            }
            else {
                input.value = "";
                ShowToastError('File size exceeds 2 MB');
                //alert('file size: ' + input.files[0].size);
            }
        }
        catch (err) {
            ShowToastError(err.message);
        }
        }

        function fncFileValidation3(input) {

            $('#<%=pdfpreview3.ClientID %>').on('change', function (e) {
                 e.preventDefault();

                 // Get the selected file
                 var selectedFile = input.files[0];

                 // Check if a file is selected
                 if (selectedFile) {
                     // Check the file extension
                     var fileExtension = selectedFile.name.split('.').pop().toLowerCase();

                     if (fileExtension === 'xlsx' || fileExtension === 'pdf') {
                         // Valid file type
                         // You can proceed with form submission or any other action
                         //ShowToastError('Valid file selected: ' + selectedFile.name);
                         // Uncomment the line below to submit the form
                         // $('#fileForm').submit();
                     } else {
                         input.value = "";
                         ShowToastError('Invalid file type. Please select an XLSX or PDF file.');
                     }
                 } else {
                     // No file selected
                     ShowToastError('No file selected.');
                 }
             });
         }
        function showpreview4(input) {
            try {
                fncFileValidation4(input);
                var maxsize = 2000 * 1024;
                if (input.files && input.files[0].size < maxsize) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=pdfpreview4.ClientID %>').attr('src', e.target.result);
               }
               reader.readAsDataURL(input.files[0])
           }
           else {
               input.value = "";
               ShowToastError('File size exceeds 2 MB');
               //alert('file size: ' + input.files[0].size);
           }
       }
       catch (err) {
           ShowToastError(err.message);
       }
   }

        function fncFileValidation4(input) {

            $('#<%=pdfpreview4.ClientID %>').on('change', function (e) {
                 e.preventDefault();

                 // Get the selected file
                 var selectedFile = input.files[0];

                 // Check if a file is selected
                 if (selectedFile) {
                     // Check the file extension
                     var fileExtension = selectedFile.name.split('.').pop().toLowerCase();

                     if (fileExtension === 'xlsx' || fileExtension === 'pdf') {

                         //ShowToastError('Valid file selected: ' + selectedFile.name);
                        
                     } else {
                         input.value = "";
                         ShowToastError('Invalid file type. Please select an XLSX or PDF file.');
                     }
                 } else {
                     // No file selected
                     ShowToastError('No file selected.');
                 }
             });
        }


        function showpreview5(input) {
            try {
                fncFileValidation5(input);
                var maxsize = 2000 * 1024;
                if (input.files && input.files[0].size < maxsize) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=pdfpreview5.ClientID %>').attr('src', e.target.result);
                       }
                       reader.readAsDataURL(input.files[0])
                   }
                   else {
                       input.value = "";
                       ShowToastError('File size exceeds 2 MB');
                       //alert('file size: ' + input.files[0].size);
                   }
               }
               catch (err) {
                   ShowToastError(err.message);
               }
        }

        function fncFileValidation5(input) {

            $('#<%=pdfpreview5.ClientID %>').on('change', function (e) {
                      e.preventDefault();

                      // Get the selected file
                      var selectedFile = input.files[0];

                      // Check if a file is selected
                      if (selectedFile) {
                          // Check the file extension
                          var fileExtension = selectedFile.name.split('.').pop().toLowerCase();

                          if (fileExtension === 'xlsx' || fileExtension === 'pdf') {
                              // Valid file type
                              // You can proceed with form submission or any other action
                              //ShowToastError('Valid file selected: ' + selectedFile.name);
                              // Uncomment the line below to submit the form
                              // $('#fileForm').submit();
                          } else {
                              input.value = "";
                              ShowToastError('Invalid file type. Please select an XLSX or PDF file.');
                          }
                      } else {
                          // No file selected
                          ShowToastError('No file selected.');
                      }
                  });
              }
     
        function fncTabClickEvent(data) {
            //$('#grdcolumndis').css("display", "block");
            if (data == 'Tab1') {
                $('#divGeneral').show();
                $('#divPurchase').hide();
                $('#divDepreciation').hide();
                $('#divSupportDocument').hide();
                $('#ContentPlaceHolder1_Tab1').addClass('Clicked');
                $('#ContentPlaceHolder1_Tab2').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab3').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab4').removeClass('Clicked');

            }
            if (data == 'Tab2') {
                $('#divGeneral').hide();
                $('#divPurchase').show();
                $('#divDepreciation').hide();
                $('#divSupportDocument').hide();
                $('#ContentPlaceHolder1_Tab2').addClass('Clicked');
                $('#ContentPlaceHolder1_Tab3').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').addClass('Initial');
                $('#ContentPlaceHolder1_Tab4').removeClass('Clicked');
            }

            if (data == 'Tab3') {
                $('#divGeneral').hide();
                $('#divPurchase').hide();
                $('#divDepreciation').hide();
                $('#divSupportDocument').show();
                $('#ContentPlaceHolder1_Tab3').addClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab2').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').addClass('Initial');
                $('#ContentPlaceHolder1_Tab4').removeClass('Clicked');
            }

            if (data == 'Tab4') {
                $('#divGeneral').hide();
                $('#divPurchase').hide();
                $('#divDepreciation').show();
                $('#divSupportDocument').hide();
                $('#ContentPlaceHolder1_Tab4').addClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab2').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab3').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').addClass('Initial');
            }

            return false;
        }


        function selectValue() {
            if ($("[id$='rbtMaintancePlan']").find(":checked").val() == 'Warranty') {
                $('#div_rbtWarrantyExpire').show();
                $('#divSelectAMClevel').hide();
                $('#divAMCvendor').hide();
                $('#div_rbtAMClevel').hide();

            }
            else if ($("[id$='rbtMaintancePlan']").find(":checked").val() == 'Out of Warranty') {
                $('#div_rbtWarrantyExpire').hide();
                $('#divAMCvendor').show();
                $('#divSelectAMClevel').show();
                $('#div_rbtAMClevel').show();

            }
        }
        function fncSelectAMClevel() {
            var a = $("#<%=ddlSelectAMClevel.ClientID%>").val();
            if ($("#<%=ddlSelectAMClevel.ClientID%>").val() == 'Non-AMC') {
                $('#divAMCdetails').hide();
            }
            else if ($("#<%=ddlSelectAMClevel.ClientID%>").val() == 'AMC') {
                $('#divAMCdetails').show();
            }

        }
        function choosePhoto() {
            var file = Android.choosePhoto();
            window.alert("file = " + file);
        }
        function fncSaveVAlidation() {
            var status = true;
            if ($("#<%=txtAssetCode.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Asset Code');ssss
                status = false;
            }
            else if ($("#<%=txtAssetName.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Asset Name');
                status = false;
            }

            else if ($('#<%=ddlDepartment.ClientID %>').val() == '0' || $('#<%=ddlDepartment.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Department');
                status = false;
            }
            else if ($('#<%=ddlLocation.ClientID %>').val() == '0' || $('#<%=ddlLocation.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Location');
                status = false;
            }
            else if ($('#<%=ddlCategory.ClientID %>').val() == '0' || $('#<%=ddlLocation.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Categoty');
                status = false;
            }
            else if ($('#<%=ddlSubCategory.ClientID %>').val() == '0' || $('#<%=ddlLocation.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Subcategoty');
                status = false;
            }
           <%--else if ($('#<%=ddlBlockName.ClientID %>').val() == '0' || $('#<%=ddlBlockName.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Block');
                status = false;
            }--%>
           <%-- else if ($('#<%=ddlFloorName.ClientID %>').val() == '0' || $('#<%=ddlFloorName.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Floor');
                status = false;
            }--%>
          <%--  else if ($('#<%=ddlRoomNo.ClientID %>').val() == '0' || $('#<%=ddlRoomNo.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Room');
                status = false;
            }--%>
            else if ($('#<%=ddlClass.ClientID %>').val() == '0' || $('#<%=ddlClass.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Class');
                status = false;
            }
         <%--   else if ($('#<%=ddlEmployee.ClientID %>').val() == '0' || $('#<%=ddlEmployee.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Employee');
                status = false;
            }--%>
            else if ($('#<%=ddlBrand.ClientID %>').val() == '0' || $('#<%=ddlBrand.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Brand');
                status = false;
            }
            else if ($('#<%=ddlVendor.ClientID %>').val() == '0' || $('#<%=ddlVendor.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Vendor');
                status = false;
            }
            else if ($('#<%=ddlStatus.ClientID %>').val() == '0' || $('#<%=ddlStatus.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Status');
                status = false;
            }
            <%--else if ($('#<%=ddlCubical.ClientID %>').val() == '0' || $('#<%=ddlStatus.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Cubical');
                status = false;
            }--%>
         <%--   else if ($("#<%=txtDocument1.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Document1 Name');
                status = false;
            }
            else if ($("#<%=txtDocument2.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Document2 Name');
                status = false;
            }
            else if ($("#<%=txtDocument3.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Document3 Name');
                status = false;
            }
            else if ($("#<%=txtDocument4.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Document4 Name');
                status = false;
            }
            else if ($("#<%=txtDocument5.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Document5 Name');
                status = false;
            }--%>

            return status;
        }
        function clearForm() {
            //$(':input').not(':button, :submit, :reset, :hidden, :checkbox, :radio').val('');
            //$(':radio').prop('checked', false);
            //$(':checkbox').prop('checked', false);
            //$(':text').val('');
            $('input[type=text]').val('');
            pageLoad();
            $("#<%=txtAssetCode.ClientID%>").val($("#<%=hidtxtAssetCode.ClientID%>").val());
            alert($("#<%=hidtxtAssetCode.ClientID%>").val());
        }
        //function fncAllowOnlyNumbers(evt) {
        //    try {
        //        if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
        //            //ShowPopupMessageBox('Allow Only Numbers');
        //            return false;
        //        }
        //    }
        //    catch (err) {
        //        ShowToastError(err.message);
        //    }
        //}


    </script>
   
   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<div class="main-container" style="overflow: hidden">--%>
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Assets</a></li>
                <li><a href="javascript:void(0);">Add Assets</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div>
                    <asp:Panel runat="server" ID="Panel1" HorizontalAlign="Center">
                        <asp:Button Text="General" OnClientClick="return fncTabClickEvent('Tab1')" ID="Tab1" CssClass="Clicked" runat="server" Style="width: 270px" />
                        <asp:Button Text="Purchase Details" OnClientClick="return fncTabClickEvent('Tab2')" ID="Tab2" CssClass="Initial" runat="server" Style="width: 270px" />
                        <asp:Button Text="Support Document" OnClientClick="return fncTabClickEvent('Tab3')" ID="Tab3" CssClass="Initial" runat="server" Style="width: 270px" />
                        <asp:Button Text="Depreciation" OnClientClick="return fncTabClickEvent('Tab4')" ID="Tab4" CssClass="Initial" runat="server" Style="width: 270px" />
                    </asp:Panel>
                </div>

                <%--<ul class="nav nav-tabs custnav-invoice custnav-cm-trans" role="tablist">
                    <li class="active"><a href="#General" aria-controls="General" role="tab" data-toggle="tab">General</a></li>
                    <li><a href="#Purchase" aria-controls="Purchase" role="tab" data-toggle="tab">Purchase Details</a></li>
                    <li><a href="#Depreciation" aria-controls="Depreciation" role="tab" data-toggle="tab">Depreciation</a></li>
                </ul>--%>
                <div id="divGeneral">
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label1" runat="server" Text="Asset Code"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtAssetCode" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label2" runat="server" Text="Asset Name"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtAssetName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label3" runat="server" Text="Department"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlDepartment" onchange="" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label4" runat="server" Text="Category"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlCategory" runat="server" onSelectedIndexChanged="ddlCategory_SelectedIndexChanged" AutoPostBack="True"  CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label6" runat="server" Text="SubCategory"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                 <asp:DropDownList ID="ddlSubCategory" runat="server"  CssClass="form-control"></asp:DropDownList>
                  <%--          <asp:DropDownList ID="ddlSubCategory" runat="server" onSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged" AutoPostBack="True"  CssClass="form-control"></asp:DropDownList>--%>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label5" runat="server" Text="Location"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                      <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label7" runat="server" Text="Class"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                     <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label9" runat="server" Text="Brand"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right" >
                                <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label27" runat="server" Text="Block" Visible ="False"></asp:Label>
                            </div>
                            <div class="control-right" style="display:none;">
                               <asp:DropDownList ID="ddlBlockName" runat="server" CssClass="form-control" ></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label28" runat="server" Text="Floor" Visible ="False"></asp:Label>
                            </div>
                            <div class="control-right" style="display:none;">
                                <asp:DropDownList ID="ddlFloorName" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left" style="display:none;">
                                <asp:Label ID="Label29" runat="server" Text="Room" Visible ="False"></asp:Label>
                            </div>
                            <div class="control-right" style="display:none;">
                                <asp:DropDownList ID="ddlRoomNo" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                  
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label8" runat="server" Text="Employee" Visible ="False"></asp:Label>
                            </div>
                            <div class="control-right" style="display:none;">
                                <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                   
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label38" runat="server" Text="Cubical" Visible ="False"></asp:Label>
                            </div>
                            <div class="control-right"style="display:none;">
                                <asp:DropDownList ID="ddlCubical" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="divPurchase" style="display: none;">
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label10" runat="server" Text="Vendor"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlVendor" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label11" runat="server" Text="UOM"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtUnit" runat="server" Style="text-align: right !important;" type="tel" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label12" runat="server" Text="Unit Price"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtUnitPrice" type="tel" Style="text-align: right !important;" onkeypress="return  fncAllowOnlyNumbers(event)" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label13" runat="server" Text="Purchase Price"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtPurchasePrice" type="tel" Style="text-align: right !important;" onkeypress="return fncAllowOnlyNumbers(event)" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label14" runat="server" Text="Model"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtModel" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label15" runat="server" Text="Serial"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtSerial" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label16" runat="server" Text="Purchase Date"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtDateAcquired" onfocus="blur();" runat="server" BackColor="White" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="control-left">
                                <asp:Label ID="Label17" runat="server" Text="Status"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div id="divImageUpload" style="display: block;">
                            <div class="control-left">
                                <asp:Label ID="Label32" runat="server" Text="Asset Image"></asp:Label>
                            </div>
                            <asp:Panel runat="server" ID="Panel2" HorizontalAlign="Center">

                                <asp:Image ID="imgpreview" runat="server" Style="align-content: center;" Height="100px" Width="150px" />
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="lnkSave" />
                                    </Triggers>
                                    <ContentTemplate>
                                        <asp:FileUpload Style="float: right" accept="image/*" ID="fuimage" runat="server" onchange="showpreview(this);" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel>
                        </div>
                    </div>
                    <%--<div id="htmlImage">
                            <input type='file' accept="image/*" onchange="readURL(this);" />
                            <img id="blah" src="#" alt="your image" />
                            <input type="button" value="Choose Photo" onclick="choosePhoto()" />
                        </div>--%>
                </div>

                <div id="divDepreciation" style="display: none;">
                    <div class="control-group" role="tabpanel" id="Depreciation" style="background-color: #fff; color: black; font-weight: bolder;">
                        <div class="col-md-12">
                            <asp:Label ID="Label33" runat="server" Text="Maintance Plan"></asp:Label>
                        </div>
                    </div>
                    <div style="border: 1px solid green; padding: 3px 6px">
                        <asp:RadioButtonList ID="rbtMaintancePlan" RepeatDirection="Horizontal" onchange="return selectValue();" runat="server">
                            <asp:ListItem Text="Warranty" Value="Warranty" Selected="True" />
                            <asp:ListItem Text="Out of Warranty" Value="Out of Warranty" />
                        </asp:RadioButtonList>

                        <div id="divSelectAMClevel" style="display: none;" class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label34" runat="server" Text="Select AMC Level"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <%--<asp:DropDownList ID="ddlSelectAMClevel" runat="server" CssClass="form-control"></asp:DropDownList>--%>
                                    <asp:DropDownList ID="ddlSelectAMClevel" CssClass="form-control" onchange="fncSelectAMClevel()" runat="server">
                                        <asp:ListItem Enabled="true" Text="--Select--" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="AMC" Value="AMC"></asp:ListItem>
                                        <asp:ListItem Text="Non-AMC" Value="Non-AMC"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div id="divAMCdetails">
                            <div id="divAMCvendor" style="display: none;">
                                <div class="control-group">
                                    <div class="col-md-12">
                                        <div class="control-left">
                                            <asp:Label ID="Label18" runat="server" Text="AMC Vendor"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlAMCvendor" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <div class="col-md-12">
                                        <div class="control-left">
                                            <asp:Label ID="Label19" runat="server" Text="AMC Amount"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtAMCamount" type="tel" Style="text-align: right !important;" onkeypress="return fncAllowOnlyNumbers(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="col-md-12">
                                    <div class="control-left">
                                        <asp:Label ID="Label20" runat="server" Text="Start Date"></asp:Label>
                                    </div>
                                    <div class="control-right">
                                        <asp:TextBox ID="txtStatrtDate" onfocus="blur();" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="control-group">
                                <div class="col-md-12">
                                    <div class="control-left">
                                        <asp:Label ID="Label21" runat="server" Text="End Date"></asp:Label>
                                    </div>
                                    <div class="control-right">
                                        <asp:TextBox ID="txtEndDate" onfocus="blur();" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div id="div_rbtWarrantyExpire" class="control-group">
                                <div class="col-md-12">
                                    <div class="control-left">
                                        <asp:Label ID="Label35" runat="server" Text="Caution while Warranty Expires"></asp:Label>
                                    </div>
                                    <div class="control-right">
                                        <asp:RadioButtonList ID="rbtWarrantyExpire" RepeatDirection="Horizontal" runat="server">
                                            <asp:ListItem Text="Yes" Value="Yes" Selected="True" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:RadioButtonList>
                                    </div>

                                </div>
                            </div>
                            <div id="div_rbtAMClevel" style="display: none;">
                                <asp:RadioButtonList ID="rbtAMClevel" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Text="Comprehensive AMC" Value="Comprehensive AMC" Selected="True" />
                                    <asp:ListItem Text="Non-Comprehensive AMC" Value="Non-Comprehensive AMC" />
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <div class="control-group" style="background-color: #fff; color: black; font-weight: bolder;">
                        <div class="col-md-12">
                            <asp:Label ID="Label36" runat="server" Text="Depreciation"></asp:Label>
                        </div>
                    </div>
                    <div style="border: 1px solid green; padding: 3px 6px">
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label22" runat="server" Text="Method"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <%--<asp:DropDownList ID="ddlMethod" runat="server" CssClass="form-control"></asp:DropDownList>--%>
                                    <asp:DropDownList ID="ddlMethod" CssClass="form-control" runat="server">
                                        <asp:ListItem Enabled="true" Text="--Select--" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="Straight Line Method" Value="Straight Line Method"></asp:ListItem>
                                        <asp:ListItem Text="Written Down Value Method" Value="Written Down Value Method"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label23" runat="server" Text="Total Cost"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtTotalCost" type="tel" Style="text-align: right !important;" onkeypress="return fncAllowOnlyNumbers(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label24" runat="server" Text="Useful Life (Yrs)"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtUsefulLife" Style="text-align: right !important;" type="tel" onkeypress="return fncAllowOnlyNumbers(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label25" runat="server" Text="Salvage Value"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtSalvageValue" Style="text-align: right !important;" type="tel" onkeypress="return fncAllowOnlyNumbers(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label26" runat="server" Text="Rate of Depreciation(%)"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtRateofDepreciation" Style="text-align: right !important;" type="tel" onkeypress="return fncAllowOnlyNumbers(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="button-control">
                            <asp:LinkButton ID="lnkSave" runat="server" OnClick="lnkSave_Click" OnClientClick="return fncSaveVAlidation();" CssClass="btn btn-success waves-effect">Save</asp:LinkButton>

                        </div>
                    </div>
                    <div class="control-group" style="background-color: #fff; color: black; font-weight: bolder;">
                        <div class="col-md-12">
                            <asp:Label ID="Label30" runat="server" Text="Printer"></asp:Label>
                        </div>
                    </div>
                    <div style="border: 1px solid green; padding: 3px 6px">
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label31" runat="server" Text="Printer Name"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:DropDownList ID="ddlPrinterName" CssClass="form-control" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div style="display: none" class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label37" runat="server" Text="Template Code"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:DropDownList ID="ddlTemplate" CssClass="form-control" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="button-control">
                            <asp:LinkButton ID="lnkPrint" runat="server" OnClick="lnkPrint_Click" CssClass="btn btn-success waves-effect">Print</asp:LinkButton>
                        </div>
                        <%-- </div>--%>
                    </div>

                </div>
                <div id="divSupportDocument" style="display: none;">
                    <div class="control-group" style="margin-top: 55px">
                 <%--       <div class="col-md-12">
                            <div class="control-left" style="width: 200px">
                                <asp:Label ID="lblDocument" runat="server" Text="Document"></asp:Label>
                            </div>
                            <div class="control-left" style="width: 200px">
                                <asp:Label ID="lblDocumentName" runat="server" Text="DocumentName"></asp:Label>
                            </div>
                        </div>--%>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12" style="margin-top: 40px">

                            <div class="col-md-4">
                                <div class="control-left" style="width: 200px; margin-left: 6px">
                                    <asp:Label ID="lblDocument1" runat="server" Text="Document1"></asp:Label>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="control-right" style="width: 200px; margin-right: 330px">
                                    <asp:TextBox ID="txtDocument1" Style="margin-left: -167px" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="control-right" style="width: 200px">
                                    <asp:Panel runat="server" ID="Panel3" HorizontalAlign="Center">

                                        <asp:UpdatePanel ID="pdfpreview1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <Triggers>
                                                <asp:PostBackTrigger ControlID="lnkSave" />
                                            </Triggers>
                                            <ContentTemplate>
                                                <asp:FileUpload Style="float: right; margin-right: 236px" accept=".pdf,.xlsx" ID="FileUpload1" runat="server" onchange="showpreview1(this);" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </asp:Panel>

                                </div>
                            </div>

                          <%--  <div class="button-control" style="margin-right: 290px; margin-top: -31px">
                                <asp:LinkButton ID="lnkUpload" runat="server" CssClass="btn btn-primary waves-effect">Upload</asp:LinkButton>
                                <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-danger waves-effect">Clear</asp:LinkButton>
                            </div>--%>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12" style="margin-top: 10px">

                                <div class="col-md-4">
                                    <div class="control-left" style="width: 200px">
                                        <asp:Label ID="lblDocument2" runat="server" Text="Document2"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px; margin-right: 330px">
                                        <asp:TextBox ID="txtDocument2" Style="margin-left: -167px" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px">
                                        <asp:Panel runat="server" ID="Panel4" HorizontalAlign="Center">

                                            <asp:UpdatePanel ID="pdfpreview2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="lnkSave" />
                                                </Triggers>
                                                <ContentTemplate>
                                                    <asp:FileUpload Style="float: right; margin-right: 236px" accept=".pdf,.xlsx" ID="FileUpload2" runat="server" onchange="showpreview2(this);" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:Panel>

                                    </div>
                                </div>
                             <%--   <div class="button-control" style="margin-right: 286px; margin-top: -31px">
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary waves-effect">Upload</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-danger waves-effect">Clear</asp:LinkButton>
                                </div>--%>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12" style="margin-top: 10px">

                                <div class="col-md-4">
                                    <div class="control-left" style="width: 200px">
                                        <asp:Label ID="lblDocument3" runat="server" Text="Document3"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px; margin-right: 330px">
                                        <asp:TextBox ID="txtDocument3" Style="margin-left: -167px" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px">
                                        <asp:Panel runat="server" ID="Panel5" HorizontalAlign="Center">

                                            <asp:UpdatePanel ID="pdfpreview3" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="lnkSave" />
                                                </Triggers>
                                                <ContentTemplate>
                                                    <asp:FileUpload Style="float: right; margin-right: 236px" accept=".pdf,.xlsx" ID="FileUpload3" runat="server" onchange="showpreview3(this);" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:Panel>

                                    </div>
                                </div>
                           <%--     <div class="button-control" style="margin-right: 286px; margin-top: -31px">
                                    <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-primary waves-effect">Upload</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton4" runat="server" CssClass="btn btn-danger waves-effect">Clear</asp:LinkButton>
                                </div>--%>


                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12" style="margin-top: 10px">

                                <div class="col-md-4">
                                    <div class="control-left" style="width: 200px">
                                        <asp:Label ID="lblDocument4" runat="server" Text="Document4"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px; margin-right: 330px">
                                        <asp:TextBox ID="txtDocument4" Style="margin-left: -167px" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px">
                                        <asp:Panel runat="server" ID="Panel6" HorizontalAlign="Center">

                                            <asp:UpdatePanel ID="pdfpreview4" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="lnkSave" />
                                                </Triggers>
                                                <ContentTemplate>
                                                    <asp:FileUpload Style="float: right; margin-right: 236px" accept=".pdf,.xlsx" ID="FileUpload4" runat="server" onchange="showpreview4(this);" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:Panel>

                                    </div>
                                </div>
                           <%--     <div class="button-control" style="margin-right: 286px; margin-top: -31px">
                                    <asp:LinkButton ID="LinkButton5" runat="server" CssClass="btn btn-primary waves-effect">Upload</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton6" runat="server" CssClass="btn btn-danger waves-effect">Clear</asp:LinkButton>
                                </div>--%>


                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12" style="margin-top: 10px">

                                <div class="col-md-4">
                                    <div class="control-left" style="width: 200px">
                                        <asp:Label ID="lblDocument5" runat="server" Text="Document5"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px; margin-right: 330px">
                                        <asp:TextBox ID="txtDocument5" Style="margin-left: -167px" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px">
                                        <asp:Panel runat="server" ID="Panel7" HorizontalAlign="Center">

                                            <asp:UpdatePanel ID="pdfpreview5" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="lnkSave" />
                                                </Triggers>
                                                <ContentTemplate>
                                                    <asp:FileUpload Style="float: right; margin-right: 236px" accept=".pdf,.xlsx" ID="FileUpload5" runat="server" onchange="showpreview5(this);" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:Panel>

                                    </div>
                                </div>
                             <%--   <div class="button-control" style="margin-right: 286px; margin-top: -31px">
                                    <asp:LinkButton ID="LinkButton7" runat="server" CssClass="btn btn-primary waves-effect">Upload</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton8" runat="server" CssClass="btn btn-danger waves-effect">Clear</asp:LinkButton>
                                </div>--%>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <asp:HiddenField ID="hidtxtAssetCode" runat="server" Value="" />
        <asp:HiddenField ID="hdnCheck" runat="server" Value="" />
         <asp:HiddenField ID="hdn1" runat="server" Value="0" />
         <asp:HiddenField ID="hdn2" runat="server" Value="0" />
         <asp:HiddenField ID="hdn3" runat="server" Value="0" />
         <asp:HiddenField ID="hdn4" runat="server" Value="0" />
         <asp:HiddenField ID="hdn5" runat="server" Value="0" />
    </div>
</asp:Content>
