function newp {

    usage="Usage: $(basename "$0") <PROJECTNAME> 
    Creates directory in your workspace and adds this to github and fw
    Excample: $(basename "$0") hannibal 
    where:
    PROJECTNAME the name of the new project "

    if [ "$#" -lt 1 ]; then
        >&2 echo "$usage"
        false
    else  
        workspace=$HOME/workspace
        newprojectname=$1

        pathToProject=$workspace/$newprojectname
        mkdir $pathToProject 
        cd $pathToProject
        hub init
        hub create
        echo $newprojectname > readme.md
        git add readme.md
        git commit -m "init $newprojectname"
        git push --set-upstream origin master
        fw import $pathToProject 
        eval $(fw gen-workon $newprojectname)
        echo "project $newprojectname sucessfully created"
    fi
}