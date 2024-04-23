#!python

import argparse
import pandas as pd

def parse_arguments():
    parser = argparse.ArgumentParser(description="Process two BED files.")
    parser.add_argument("target_bed", help="BED file with transcriptome coordinates that will be lifted to genomic coordinates.")
    parser.add_argument("annotation_bed", help="BED file with the transcriptome annotation.")
    parser.add_argument("-t", "--target_col", type=int, default=0, help="Column fom the target bed to use for joining with the annotation.")
    parser.add_argument("-a", "--annotation_col", type=int, default=3, help="Column fom the target bed to use for joining with the annotation.")
    parser.add_argument("--header", action='store_true', help="Indicates whether the target BED has a header.")
    parser.add_argument("-o", "--output", help="Save results to the specified file instead of printing them to stdout.")
    return parser.parse_args()

def main():
    args = parse_arguments()
    
    header = 0 if args.header else None

    target = pd.read_csv(args.target_bed, sep='\t', header=header)
    target.columns = map(str, target.columns)
    annotation = pd.read_csv(args.annotation_bed, sep='\t', header=None)
    annotation.columns = map(str, annotation.columns)

    cols = target.columns

    target_col = str(args.target_col)
    annotation_col = str(args.annotation_col)

    result = target.join(annotation.set_index(annotation_col),
                         on=target_col,
                         how='inner',
                         rsuffix='_annot')
    result['0'] = result['0_annot']
    result['1'] += result['1_annot']
    result['2'] += result['1_annot']
    result = result.loc[:, cols]

    del target
    del annotation

    if args.output:
        result.to_csv(args.output, sep='\t', header=False, index=False)
    else:
        for _, line in result.iterrows():
            print('\t'.join(map(str, line)))


if __name__ == "__main__":
    main()
