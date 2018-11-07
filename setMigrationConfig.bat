@echo off

REM ####### BEGIN - EDITABLE CONFIGURATION #######

REM Set Java home to valid JRE 1.6 location.
REM Quotes should not be used around the value.
set JAVA_HOME="C:\Program Files\Java\jre8"

REM Set Max heap size for JRE
set MAX_HEAP_SIZE=-Xmx1024m

REM Set number of threads for the Content Management Migration Tool / Archive Migration Tool (Phase 2) to use.
set NUM_THREADS_FOR_ATTACHMENTS=5

REM Set number of threads for the Archive Migration Tool (Phase 1) to use.
set NUM_THREADS=10

REM Set the logging level for the migration tools.  This value can be one,
REM and only one, of: '-silent', '-quiet', '-verbose'
set LOG_LEVEL=-verbose

REM BEGIN - Database settings

REM *** Example configuration for Oracle
REM Note that this is the latest driver class name.  The oracle.jdbc.driver.OracleDriver is a deprecated driver.
REM set DATABASE_DRIVER=oracle.jdbc.OracleDriver
REM set DATABASE_URL=jdbc:oracle:thin:@mspdbvm3:1521:ODEVD20

REM *** Example configuration for DB2
REM DATABASE_DRIVER=com.ibm.db2.jcc.DB2Driver
REM DATABASE_URL=jdbc:db2://mspdb201.paisley.com:50002/DDEVD03

set DATABASE_DRIVER="oracle.jdbc.driver.OracleDriver"
set DATABASE_URL="jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=grc-scan-bd0150.int.thomsonreuters.com)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ohstd23a.int.thomsonreuters.com)))"
set DATABASE_USERNAME="blrnavqaentwl32"
set DATABASE_PASSWORD="blrnavqaentwl32"

REM END - Database settings

REM Set appropriate class for XML parser factory
REM *** Uncomment for Sun JDK
set DOC_BUILDER=com.sun.org.apache.xerces.internal.jaxp.DocumentBuilderFactoryImpl
REM *** Uncomment for IBM JDK
REM set DOC_BUILDER=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl


REM BEGIN - Application settings

REM Specify an arbitrary (but valid) node ID
REM Most users will use the default of 4095. You *should* only need to
REM change this for a clustered environment.
set NODE_ID=4095

REM Specify a valid client ID
REM "client001" is the only valid setting
set CLIENT_ID=client001

REM Set the reporting periods to process as required by the Archive migration
REM tool.  This can either be 'all' or a comma separated list of reporting
REM period IDs.  Run the ArchiveReportingPeriodTool prior to running the
REM ArchiveMigrationTool to get a list of all reporting period IDs.
set REPORTINGPERIODS=all

REM END - Application settings

REM ####### END - EDITABLE CONFIGURATION #######

REM Setting the -Dclient.encoding.override=UTF-8 parameter should be sufficient. But, I am also 
REM setting NLS_LANG for Oracle since it is mentioned as a possible workaround for ORA-01461.
set NLS_LANG=UTF8

set MYDIR=%~dp0
REM explicitly specifying the Java1.5 included xml parser (don't want overrides from other jars)
set VMARGS=-ea %MAX_HEAP_SIZE% -DPaisley.NodeID=%NODE_ID% -Dclient.encoding.override=UTF-8 -Djavax.xml.parsers.DocumentBuilderFactory=%DOC_BUILDER%
set LIBDIR=%MYDIR%lib

REM If MYCP is not set run the target 'BuildToolsPackage in the script 'Build EAR file' then,
REM open EJB\build\PaisleyTools.zip \PaisleyTools\setMigrationConfig.bat and copy the value here.
set MYCP=%LIBDIR%;%LIBDIR%\RNJEJB.jar;%LIBDIR%\DBPatches.jar;%LIBDIR%\PatchTool.jar;%LIBDIR%\activation-1.1.jar;%LIBDIR%\antisamy-1.4.2-bin.jar;%LIBDIR%\axil-api.jar;%LIBDIR%\axil-engine.jar;%LIBDIR%\batik-css.jar;%LIBDIR%\batik-util.jar;%LIBDIR%\bcel-5.3-SNAPSHOT.jar;%LIBDIR%\bsh-2.0b4.jar;%LIBDIR%\commons-beanutils-bean-collections.jar;%LIBDIR%\commons-beanutils-core.jar;%LIBDIR%\commons-beanutils.jar;%LIBDIR%\commons-codec-1.3.jar;%LIBDIR%\commons-collections.jar;%LIBDIR%\commons-digester.jar;%LIBDIR%\commons-fileupload-1.2.2.jar;%LIBDIR%\commons-httpclient-3.1.jar;%LIBDIR%\commons-io-2.1.jar;%LIBDIR%\commons-lang.jar;%LIBDIR%\commons-logging-1.1.1.jar;%LIBDIR%\commons-pool.jar;%LIBDIR%\commons-validator.jar;%LIBDIR%\esapi-2.0.1.jar;%LIBDIR%\guava-14.0.1.jar;%LIBDIR%\guava-15.0.jar;%LIBDIR%\guava-16.0.1.jar;%LIBDIR%\javax.servlet.jar;%LIBDIR%\javax.servlet.jsp.jar;%LIBDIR%\jbosssx.jar;%LIBDIR%\jdbm-1.0.jar;%LIBDIR%\joda-time-1.6.2.jar;%LIBDIR%\jregex1.2_01.jar;%LIBDIR%\jsr173_1.0_api.jar;%LIBDIR%\ldapbp.jar;%LIBDIR%\log4j.jar;%LIBDIR%\mail-1.4.jar;%LIBDIR%\nekohtml.jar;%LIBDIR%\oro-2.0.7.jar;%LIBDIR%\poi-3.6-20091214.jar;%LIBDIR%\sax.jar;%LIBDIR%\saxpath.jar;%LIBDIR%\servlet-api-2.3.jar;%LIBDIR%\struts-legacy.jar;%LIBDIR%\struts.jar;%LIBDIR%\wsdl4j.jar;%LIBDIR%\wssec.jar;%LIBDIR%\xercesImpl.jar;%LIBDIR%\xml-apis-ext.jar;%LIBDIR%\xml-apis.jar;%LIBDIR%\ojdbc6_g.jar;%LIBDIR%\orai18n.jar

REM Common Tool Args - database info and client
set COMMON_TOOL_ARGS=-driver %DATABASE_DRIVER% -url %DATABASE_URL% -user %DATABASE_USERNAME% -password %DATABASE_PASSWORD% -clientID %CLIENT_ID%