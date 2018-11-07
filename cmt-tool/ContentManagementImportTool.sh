#!/bin/sh

## *** Call setMigrationConfig.sh to set shared configuration
SCRIPTDIR=`dirname "$0"`
SCRIPTDIR=`cd "$SCRIPTDIR" && pwd`
. "${SCRIPTDIR}/../setMigrationConfig.sh"
LOG_DIR="${SCRIPTDIR}/logs"
[ -d "${LOG_DIR}" ] || mkdir "${LOG_DIR}"

## Set the absolute path to the index file. 
INDEX_FILE="<<indexfile>>"

${JAVA_HOME}/bin/java -cp "${MYCP}:${CLASSPATH}" ${VMARGS} com.paisley.rnj.content.tool.ContentManagementImportTool -driver ${DATABASE_DRIVER} -url ${DATABASE_URL} -user ${DATABASE_USERNAME} -password ${DATABASE_PASSWORD} -clientID ${CLIENT_ID} -logs ${LOG_DIR} ${LOG_LEVEL} -threads ${NUM_THREADS_FOR_ATTACHMENTS} -indexFile ${INDEX_FILE}
