#!/bin/sh

## ####### BEGIN - EDITABLE CONFIGURATION #######

# Set Java home to valid JRE 1.6 location.
JAVA_HOME="<<JAVA_HOME>>"

## Set Max heap size for JRE
MAX_HEAP_SIZE=-Xmx1024m

## Set number of threads for the Content Management Migration Tool / Archive Migration Tool (Phase 2) to use.
NUM_THREADS_FOR_ATTACHMENTS=5

## Set number of threads for the Archive Migration Tool (Phase 1) to use.
NUM_THREADS=10

## Set the logging level for the migration tools.  This value can be one,
## and only one, of: '-silent', '-quiet', '-verbose'
LOG_LEVEL=-verbose

## BEGIN - Database settings

## *** Example configuration for Oracle
## Note that this is the latest driver class name.  The oracle.jdbc.driver.OracleDriver is a deprecated driver.
## DATABASE_DRIVER=oracle.jdbc.OracleDriver
## DATABASE_URL=jdbc:oracle:thin:@mspdbvm3:1521:ODEVD20

## *** Example configuration for DB2
## DATABASE_DRIVER=com.ibm.db2.jcc.DB2Driver
## DATABASE_URL=jdbc:db2://mspdb201.paisley.com:50002/DDEVD03

DATABASE_DRIVER="<<driver>>"
DATABASE_URL="<<url>>"
DATABASE_USERNAME="<<username>>"
DATABASE_PASSWORD="<<password>>"

## END - Database settings

## Set appropriate class for XML parser factory
## *** Uncomment for Sun JDK
DOC_BUILDER=com.sun.org.apache.xerces.internal.jaxp.DocumentBuilderFactoryImpl
## *** Uncomment for IBM JDK
## DOC_BUILDER=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl


## BEGIN - Application settings

## Specify an arbitrary (but valid) node ID
## Most users will use the default of 4095. You *should* only need to
## change this for a clustered environment.
NODE_ID=4095

## Specify a valid client ID
## "client001" is the only valid setting
CLIENT_ID=client001

## Set the reporting periods to process as required by the Archive migration
## tool.  This can either be 'all' or a comma separated list of reporting
## period IDs.  Run the ArchiveReportingPeriodTool prior to running the
## ArchiveMigrationTool to get a list of all reporting period IDs.
REPORTINGPERIODS=all

## END - Application settings

## ####### END - EDITABLE CONFIGURATION #######

MYDIR=`dirname "$0"`/..
MYDIR=`cd "$MYDIR" && pwd`
LIBDIR=`cd "$MYDIR"/lib && pwd`
VMARGS="-ea ${MAX_HEAP_SIZE} -DPaisley.NodeID=${NODE_ID} -Djavax.xml.parsers.DocumentBuilderFactory=${DOC_BUILDER}"

# If MYCP is not set run the target 'BuildToolsPackage in the script 'Build EAR file' then,
# open EJB\build\PaisleyTools.zip \PaisleyTools\setMigrationConfig.bat and copy the value here.
MYCP=${LIBDIR}:${LIBDIR}/RNJEJB.jar:${LIBDIR}/DBPatches.jar:${LIBDIR}/PatchTool.jar:${LIBDIR}/activation-1.1.jar:${LIBDIR}/antisamy-1.4.2-bin.jar:${LIBDIR}/axil-api.jar:${LIBDIR}/axil-engine.jar:${LIBDIR}/batik-css.jar:${LIBDIR}/batik-util.jar:${LIBDIR}/bcel-5.3-SNAPSHOT.jar:${LIBDIR}/bsh-2.0b4.jar:${LIBDIR}/commons-beanutils-bean-collections.jar:${LIBDIR}/commons-beanutils-core.jar:${LIBDIR}/commons-beanutils.jar:${LIBDIR}/commons-codec-1.3.jar:${LIBDIR}/commons-collections.jar:${LIBDIR}/commons-digester.jar:${LIBDIR}/commons-fileupload-1.2.2.jar:${LIBDIR}/commons-httpclient-3.1.jar:${LIBDIR}/commons-io-2.1.jar:${LIBDIR}/commons-lang.jar:${LIBDIR}/commons-logging-1.1.1.jar:${LIBDIR}/commons-pool.jar:${LIBDIR}/commons-validator.jar:${LIBDIR}/esapi-2.0.1.jar:${LIBDIR}/guava-14.0.1.jar:${LIBDIR}/guava-15.0.jar:${LIBDIR}/guava-16.0.1.jar:${LIBDIR}/javax.servlet.jar:${LIBDIR}/javax.servlet.jsp.jar:${LIBDIR}/jbosssx.jar:${LIBDIR}/jdbm-1.0.jar:${LIBDIR}/joda-time-1.6.2.jar:${LIBDIR}/jregex1.2_01.jar:${LIBDIR}/jsr173_1.0_api.jar:${LIBDIR}/ldapbp.jar:${LIBDIR}/log4j.jar:${LIBDIR}/mail-1.4.jar:${LIBDIR}/nekohtml.jar:${LIBDIR}/oro-2.0.7.jar:${LIBDIR}/poi-3.6-20091214.jar:${LIBDIR}/sax.jar:${LIBDIR}/saxpath.jar:${LIBDIR}/servlet-api-2.3.jar:${LIBDIR}/struts-legacy.jar:${LIBDIR}/struts.jar:${LIBDIR}/wsdl4j.jar:${LIBDIR}/wssec.jar:${LIBDIR}/xercesImpl.jar:${LIBDIR}/xml-apis-ext.jar:${LIBDIR}/xml-apis.jar:${LIBDIR}/xmlunit-1.3.jar:${LIBDIR}/ojdbc6_g.jar:${LIBDIR}/orai18n.jar

if [ `uname | cut -c1-6` = "CYGWIN" ] ; then
	MYCP=`cygpath -pws "$MYCP"`
fi

## Common Tool Args - database info and client
COMMON_TOOL_ARGS="-driver ${DATABASE_DRIVER} -url ${DATABASE_URL} -user ${DATABASE_USERNAME} -password ${DATABASE_PASSWORD} -clientID ${CLIENT_ID}"