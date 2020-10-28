#
# This file is autogenerated on every push of files in '.github/data'
#

name: Manifest workflow

# Controls when the action will run. Triggers the workflow on push or pull request events but
# only for the main branch
on:
  repository_dispatch:
    types: [ build_application ]

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          ref: ${{ github.head_ref }}
      {{ACTIONS}}
      - name:
        run: ( Get-ChildItem -Path . -Filter iocage* ) | Foreach-Object { Copy-Item -Path "$($_.FullName)/manifest.json" -Destination "$($_.Name).json" }
        shell: pwsh
      - name: Get current date
        id: get-current-date
        run: echo "::set-output name=date::$(date '+%d/%m/%Y')"
        shell: bash
      - uses: stefanzweifel/git-auto-commit-action@v4
        with:
          branch: master
          commit_author: PiESTR.Bot <github.bot@piestr.fr>
          commit_message: "[${{ steps.get-current-date.outputs.date }}] Manifest update"
