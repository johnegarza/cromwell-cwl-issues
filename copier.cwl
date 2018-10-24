#! /usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ['/bin/cp']

requirements:
    - class: ShellCommandRequirement
    - class: DockerRequirement
      dockerPull: "ubuntu:xenial"

inputs:
    source_file:
        type: File 
        inputBinding:
            position: 1
    destination_file:
        type: string
        inputBinding:
            position: 2
outputs:
    copied_files:
        type:
            type: array
            items: File
        outputBinding:
            glob: "*txt"
