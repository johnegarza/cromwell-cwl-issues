#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
    - class: SubworkflowFeatureRequirement
    - class: MultipleInputFeatureRequirement

inputs:
    first_file:
        type: File
    second_file:
        type: File
    output_dir:
        type: string

outputs:
    final:
        type: string[]
        outputSource: gatherer/gathered_files

steps:
    copy1:
        run: copier.cwl
        in:
            source_file: first_file
            destination_file:
                valueFrom: "first_copy.txt"
        out:
            [copied_files]
    copy2:
        run: copier.cwl
        in:
            source_file: second_file
            destination_file:
                valueFrom: "second_copy.txt"
        out:
            [copied_files]
    gatherer:
        run: gatherer.cwl
        in:
            output_dir: output_dir 
            all_files:
                source: [copy1/copied_files, copy2/copied_files]
                linkMerge: merge_flattened
        out:
            [gathered_files]
