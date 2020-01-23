if (!($GITHUB_TOKEN)) {
    
}

(cat template.gitconfig) -match "%GITHUBTOKEN%" -replace $GIITHUB_TOKEN | Out-File ~/.gitconfig
