SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

MYSQL_LOGIN="root"
MYSQL_PASSWORD="rootUser"

UPDATE_SCRIPT="updateLessonsInProgress.sh"
CREATE_DUMP_SCRIPT="createDumpOfDatabase.sh"

echo "*/1 * * * * bash ${SCRIPT_DIR}/${UPDATE_SCRIPT}" > crontab.txt
echo "*/1 * * * * bash ${SCRIPT_DIR}/${CREATE_DUMP_SCRIPT}" >> crontab.txt
crontab crontab.txt

echo ""
