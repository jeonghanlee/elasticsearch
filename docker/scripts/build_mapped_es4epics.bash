

DEFAULT_TARGET_NAME="es4epics"

function prn
{
	local a="$1"; shift;
    local b="$1"; shift;
    local c="$1"; shift;
	printf "\\n>>> %s ---------\\n"  "${a}" ;
    printf ">>> Committing ..%s at %s\\n" "${b}" "${c}";
}


function usage
{
    {
	echo "";
	echo "Usage    : $0 [-s IMAGE ID] <-n docker taget name> [-t Release Version] <build>"
	echo "";
	echo "               -u   : Docker HUB user name (default:jeonghanlee)";
	echo "               -n   : Target name (default:es4epics)";
	echo "               -t   : Desired Release Version";
	echo "               push : without push, it is dry-run."
	echo "";
	echo " ---- Dry run"
	echo " $ bash $0 -u \"jeonghanlee\" -n \"es4epics\" -t \"v1.0.1\""
	echo "";
	echo " ---- build the modified docker image"
	echo " $ bash $0 -t \"v1.0.1\" push"
	echo ""
    } 1>&2;
    exit 1;
}



options=":t:n:u:"

while getopts "${options}" opt; do
    case "${opt}" in
        t) 
			target_version=${OPTARG}
			;;
		n) 
			target_name=${OPTARG}
			;;
		u) 
			USER_NAME=${OPTARG}
			;;
		:)
	    	echo "Option -$OPTARG requires an argument." >&2
	    	usage
	    ;;
		h)
	    	usage
	    ;;
		\?)
	    	echo "Invalid option: -$OPTARG" >&2
	    	usage
	    ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${target_version}" ]; then
    usage;
fi

if [ -z "${target_name}" ]; then
    printf ">>> We will use the predefined target name %s\\n" "${TARGET_NAME}"
	if [ -z "${TARGET_NAME}" ]; then
	    printf "    We cannot find the default one, force to use %s\\n" "$DEFAULT_TARGET_NAME"
	    TARGET_NAME="$DEFAULT_TARGET_NAME"
	fi
else
    TARGET_NAME=${target_name};
fi

if [ -z "${USER_NAME}" ]; then
    USER_NAME="jeonghanlee"
fi


case "$1" in
    build)
    	run_cmd="eval";
		;;
	*)		
	    run_cmd="echo";
		;;
esac


container_id=$(docker ps -q --filter="NAME=$TARGET_NAME")
target_image=${USER_NAME}/${TARGET_NAME}:${target_version}
command="docker commit ${container_id} ${target_image}"

prn "$run_cmd" "$container_id" "$target_image"
${run_cmd} "${command}"