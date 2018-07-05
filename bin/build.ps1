if (($version -ge [Version]"0.7") -and (Test-Path "Project.toml")) {
    $env:JULIA_PROJECT = ".@" # TODO: change this to --project="@."
    julia -e "using Pkg; Pkg.build()"
} else {
    # Set projectname
    $projectname = (Get-Item $pwd).BaseName -replace '\.jl$',''
    if (Test-Path ".git/shallow") {
        git fetch --unshallow
    }
    julia -e "Pkg.clone(pwd(), \`"$projectname\`"); Pkg.build(\`"$projectname\`")"
}
