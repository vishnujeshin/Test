<?xml version="1.0" encoding="utf-8"?>
<!--
  For more information on how to configure your ASP.NET application, please visit
  http://go.microsoft.com/fwlink/?LinkId=169433
  -->
<configuration>
  <configSections>
    <sectionGroup name="devExpress">
      <section name="themes" type="DevExpress.Web.ASPxClasses.ThemesConfigurationSection, DevExpress.Web.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" requirePermission="false" />
      <section name="compression" type="DevExpress.Web.ASPxClasses.CompressionConfigurationSection, DevExpress.Web.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" requirePermission="false" />
      <section name="settings" type="DevExpress.Web.ASPxClasses.SettingsConfigurationSection, DevExpress.Web.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" requirePermission="false" />
      <section name="errors" type="DevExpress.Web.ASPxClasses.ErrorsConfigurationSection, DevExpress.Web.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" requirePermission="false" />
    </sectionGroup>
  </configSections>
  <!--
    For a description of web.config changes see http://go.microsoft.com/fwlink/?LinkId=235367.

    The following attributes can be set on the <httpRuntime> tag.
      <system.Web>
        <httpRuntime targetFramework="4.5.2" />
      </system.Web>
  -->
  <system.web>
    <compilation targetFramework="4.6.1">
      <assemblies>
        <add assembly="DevExpress.Web.ASPxPivotGrid.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A" />
        <add assembly="DevExpress.PivotGrid.v12.2.Core, Version=12.2.4.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A" />
        <add assembly="DevExpress.Data.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A" />
        <add assembly="DevExpress.Web.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A" />
        <add assembly="DevExpress.Printing.v12.2.Core, Version=12.2.4.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A" />
        <add assembly="System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089" />
        <add assembly="System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A" />
      </assemblies>
    </compilation>
    <httpRuntime targetFramework="4.5" />
    <httpModules>
      <add name="ApplicationInsightsWebTracking" type="Microsoft.ApplicationInsights.Web.ApplicationInsightsHttpModule, Microsoft.AI.Web" />
      <add type="DevExpress.Web.ASPxClasses.ASPxHttpHandlerModule, DevExpress.Web.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" name="ASPxHttpHandlerModule" />
    </httpModules>
    <httpHandlers>
      <add type="DevExpress.Web.ASPxClasses.ASPxHttpHandlerModule, DevExpress.Web.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" verb="GET" path="DX.ashx" validate="false" />
    </httpHandlers>
  </system.web>
  <system.codedom>
    <compilers>
      <compiler language="c#;cs;csharp" extension=".cs" type="Microsoft.CodeDom.Providers.DotNetCompilerPlatform.CSharpCodeProvider, Microsoft.CodeDom.Providers.DotNetCompilerPlatform, Version=1.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" warningLevel="4" compilerOptions="/langversion:6 /nowarn:1659;1699;1701" />
      <compiler language="vb;vbs;visualbasic;vbscript" extension=".vb" type="Microsoft.CodeDom.Providers.DotNetCompilerPlatform.VBCodeProvider, Microsoft.CodeDom.Providers.DotNetCompilerPlatform, Version=1.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" warningLevel="4" compilerOptions="/langversion:14 /nowarn:41008 /define:_MYTYPE=\&quot;Web\&quot; /optionInfer+" />
    </compilers>
  </system.codedom>
  <!--<dependentAssembly>
  <assemblyIdentity name="Microsoft.WindowsAzure.ServiceRuntime" publicKeyToken="31bf3856ad364e35" />
  <bindingRedirect oldVersion="2.0.0.0" newVersion="1.8.0.0" />
</dependentAssembly>-->
  <system.web.extensions>
    <scripting>
      <webServices>
        <!-- Update this value to set the max length -->
        <jsonSerialization maxJsonLength="2147483647" />
      </webServices>
    </scripting>
  </system.web.extensions>
  <appSettings>
    <add key="HostingArea" value="192.168.1.131" />
    <add key="DCPrintFilePath" value="E:\\velu\MyDocs\\AssetMobileApplication\\DCPrint\\" />
    <add key="PDFSaveFilePath" value="D:\AssetPDF\" />
    <add key="QRImageSave" value="D:\Rajesh\AssetMobileApplication\\AssetMobileApplication\QRCode\" />
    <add key="UserCount" value="5" />
    <!--<add key="DCPrintFilePath" value="F:\\"/>-->
    <add key="FilePath" value="D:\Rajesh\AssetMobileApplication\AssetMobileApplication\ExcelExport\\" />
    <add key="PRNPath" value="G:\Asset_Unitech\AssetMobileApplication\AssetMobileApplication\bin\AssetPRN.txt" />
    <add key="PRNPath1" value="C:\Hariharan\AssetBuild1506204\Demo1AssetBuild\AssetBuild2nd18062024\bin\AssetBarcode.txt" />
    <add key="UserCount" value="5" />
    <add key="From" value="no-reply@uniprotech.co.in" />
    <add key="Password" value="uuatolgvshsegchw" />
    <add key="To" value="hariharan@uniprotech.net" />
    <add key="Host" value="smtp.gmail.com" />
    <add key="Port" value="587" />
    <add key="Timer" value="1" />
    <add key="Title" value="Asset Request" />
    <add key="TitleBody" value="" />
    <add key="ClientSettingsProvider.ServiceUri" value="" />
    <add key="FromD" value="no-reply@uniprotech.co.in" />
    <add key="PasswordD" value="uuatolgvshsegchw" />
    <add key="ToD" value="hariharan@uniprotech.net" />
    <add key="HostD" value="smtp.gmail.com" />
    <add key="PortD" value="587" />
    <add key="TimerD" value="1" />
    <add key="TitleD" value="Asset Disposed" />
    <add key="TitleBodyD" value="" />
    <add key="ClientSettingsProvider.ServiceUri" value="" />
    <add key="FromA" value="no-reply@uniprotech.co.in" />
    <add key="PasswordA" value="uuatolgvshsegchw" />
    <add key="ToA" value="hariharan@uniprotech.net" />
    <add key="HostA" value="smtp.gmail.com" />
    <add key="PortA" value="587" />
    <add key="TimerA" value="1" />
    <add key="TitleA" value="Asset Approved" />
    <add key="TitleBodyA" value="" />
    <add key="ClientSettingsProvider.ServiceUri" value="" />
    <add key="FromDc" value="no-reply@uniprotech.co.in" />
    <add key="PasswordDc" value="uuatolgvshsegchw" />
    <add key="ToDc" value="hariharan@uniprotech.net" />
    <add key="HostDc" value="smtp.gmail.com" />
    <add key="PortDc" value="587" />
    <add key="TimerDc" value="1" />
    <add key="TitleDc" value="Asset Approved" />
    <add key="TitleBodyDc" value="" />
    <add key="ClientSettingsProvider.ServiceUri" value="" />
    <add key="FromAA" value="no-reply@uniprotech.co.in" />
    <add key="PasswordAA" value="uuatolgvshsegchw" />
    <add key="To" value="hariharan@uniprotech.net" />
    <add key="HostAA" value="smtp.gmail.com" />
    <add key="PortAA" value="587" />
    <add key="TimerAA" value="1" />
    <add key="TitleAA" value="Asset Assigned" />
    <add key="TitleBodyAA" value="" />
    <add key="ClientSettingsProvider.ServiceUri" value="" />
    <add key="FilePath" value="C:\Hariharan\Uploadpdf\\" />
    <add key="DisposalPath" value=" G:\Asset_Unitech\AssetMobileApplication\\AssetMobileApplication\\AssetDisposal\\" />
    <add key="DCEntryPath" value=" G:\Asset_Unitech\AssetMobileApplication\\AssetMobileApplication\DcEntryReport\\" />
    <add key="Handoverpath" value=" G:\Asset_Unitech\AssetMobileApplication\\AssetMobileApplication\HandoverDocument\\" />
    <add key="EmailContentTemplate" value="&lt;html&gt;&#xD;&#xA;        &lt;body&gt;&#xD;&#xA;            &lt;p&gt;Hi {0},&lt;/p&gt;&#xD;&#xA;            &lt;p&gt;A new asset has been assigned to you. Please find the asset information below. Please acknowledge the receipt.&lt;/p&gt;&#xD;&#xA;            &lt;p&gt;Asset Name&amp;nbsp;&amp;nbsp;: {1}&lt;/p&gt;&#xD;&#xA;            &lt;p&gt;Asset ID&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;: {2}&lt;/p&gt;&#xD;&#xA;            &lt;p&gt;Accessories&amp;nbsp;: None&lt;/p&gt;&#xD;&#xA;        &lt;/body&gt;&#xD;&#xA;    &lt;/html&gt;" />
  </appSettings>
  <connectionStrings>
    <!--<add name="dbConnString" connectionString="Data Source=192.168.1.164\ups2019;Initial Catalog=Asset_test; uid=sa; Password=ups@123; User Instance=False; Pooling=False; Connection Timeout=0;" />-->
    <!--  <add name="dbConnString" connectionString="Data Source=192.168.1.92\sql2019;Initial Catalog=Asset_Oman; uid=sa; Password=ups@123; User Instance=False; Pooling=False; Connection Timeout=0;" /> -->
    <add name="dbConnString" connectionString="Data Source=103.231.78.238\\MSSQLSERVER_1,9898;Initial Catalog=Asset_Presidio_10072024; uid=sa; Password=ups@123@2023!; User Instance=False; Pooling=False; Connection Timeout=0;" />
    <!--<add name="dbConnString" connectionString="Data Source=103.231.78.219;Initial Catalog=Asset_Dev; uid=sa; Password=D3m0@1234$#$; User Instance=False; Pooling=False; Connection Timeout=0;" />-->
    <!--<add name="dbConnStrings" connectionString="Data Source=192.168.1.131\sqlexpress;Initial Catalog=IoT_Demo; uid=sa; Password=ups@123; User Instance=False; Pooling=False; Connection Timeout=0;"/>-->
    <add name="dbMailConnString" connectionString="Data Source=192.168.1.58;Initial Catalog=Asset2403; uid=sa; Password=ups@123; User Instance=False; Pooling=False; Connection Timeout=0;" />
    <add name="chartconnsting" connectionString="Data Source=192.168.1.131\sqlexpress;Initial Catalog=IoT_Demo; uid=sa; Password=ups@123; User Instance=False; Pooling=False; Connection Timeout=0;" />
    <add name="Path" connectionString="C:\Hariharan\Excelupload\" />
  </connectionStrings>
  <system.webServer>
    <defaultDocument>
      <files>
        <clear />
        <add value="frmLogin.aspx" />
      </files>
    </defaultDocument>
    <staticContent>
      <remove fileExtension=".woff2" />
      <mimeMap fileExtension=".woff2" mimeType="font/woff2" />
    </staticContent>
    <validation validateIntegratedModeConfiguration="false" />
    <!--<modules>
      <remove name="ApplicationInsightsWebTracking"/>
      <add name="ApplicationInsightsWebTracking" type="Microsoft.ApplicationInsights.Web.ApplicationInsightsHttpModule, Microsoft.AI.Web" preCondition="managedHandler"/>
    </modules>-->
    <modules>
      <add type="DevExpress.Web.ASPxClasses.ASPxHttpHandlerModule, DevExpress.Web.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" name="ASPxHttpHandlerModule" />
    </modules>
    <handlers>
      <add type="DevExpress.Web.ASPxClasses.ASPxHttpHandlerModule, DevExpress.Web.v12.2, Version=12.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" verb="GET" path="DX.ashx" name="ASPxHttpHandlerModule" preCondition="integratedMode" />
    </handlers>
  </system.webServer>
  <devExpress>
    <themes enableThemesAssembly="true" styleSheetTheme="" theme="" />
    <compression enableHtmlCompression="false" enableCallbackCompression="true" enableResourceCompression="true" enableResourceMerging="true" />
    <settings rightToLeft="false" />
    <errors callbackErrorRedirectUrl="" />
  </devExpress>
  <runtime>
    <!--<assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
      <dependentAssembly>
        <assemblyIdentity name="DocumentFormat.OpenXml" publicKeyToken="31bf3856ad364e35" culture="neutral" />
        <bindingRedirect oldVersion="0.0.0.0-2.5.5631.0" newVersion="2.5.5631.0" />
      </dependentAssembly>
    </assemblyBinding>-->
    <!--<assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
      <dependentAssembly>
        <assemblyIdentity name="DocumentFormat.OpenXml" publicKeyToken="31bf3856ad364e35" culture="neutral"/>
        <bindingRedirect oldVersion="0.0.0.0-2.5.5631.0" newVersion="2.5.5631.0"/>
      </dependentAssembly>
    </assemblyBinding>-->
    <assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
      <dependentAssembly>
        <assemblyIdentity name="DocumentFormat.OpenXml" publicKeyToken="8fb06cb64d019a17" culture="neutral" />
        <bindingRedirect oldVersion="0.0.0.0-0.0.1.0" newVersion="0.0.1.0" />
      </dependentAssembly>
    </assemblyBinding>
  </runtime>
</configuration>
<!--ProjectGuid: 9E6FAAB4-874B-4B3C-B23C-A388AAF4CE3E-->
