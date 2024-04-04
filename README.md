## Introduction
Official code for ICLR 2024 paper [Do Generated Data Always Help Contrastive Learning?](https://openreview.net/pdf?id=S5EqslEHnz) authored by [Yifei Wang*](https://yifeiwang77.com/), Jizhe Zhang*, and [Yisen Wang](https://yisenwang.github.io/).

With the rise of generative models, especially diffusion models, the ability to generate realistic images close to the real data distribution has been well recognized. These generated high-equality images have been successfully applied to enhance contrastive representation learning, a technique termed ''data inflation''. However, we find that the generated data may sometimes even harm contrastive learning. We investigate the causes behind this failure from the perspective of both data inflation and data augmentation. For the first time, we reveal the complementary roles that stronger data inflation should be accompanied by weaker augmentations, and vice versa. Finally, we propose Adaptive Inflation (AdaInf), a purely data-centric strategy without introducing any extra computation cost when contrastive representation learning with data inflation. 

Our code is mostly based on the codebase [solo-learn](https://github.com/vturrisi/solo-learn), a library of self-supervised methods for unsupervised visual representation learning. You can refer to [README_solo.md](https://github.com/PKU-ML/adainf/blob/master/solo-learn/README_solo.md) for details on the installation and runing of the code. 
## Getting started
To install the main dependencies for this repo, run:

 `pip install -r requirements.txt`

## Preparing generated datasets
The generated images used for data inflation need to be converted into the npz format by running the following command:
```
python generated_data.py \
--imagedir generated_image_folder \
--outpath ./datasets/generated/name.npz

# generated_image_folder: input path of generated images
# name.npz: name of generated dataset in npz format for data inflation
```

Generated data used in this work can be accessed at the following link:
[https://drive.google.com/drive/folders/1wQGMW1ex_220O9axfzayKG4wzq8dcwCx?usp=sharing](https://drive.google.com/drive/folders/1wQGMW1ex_220O9axfzayKG4wzq8dcwCx?usp=sharing)

Including:
+ 1 million generated images of CIFAR-10 (cifar10-stf-1m.npz) and CIFAR-100 (cifar100-stf-1m.npz) from [STF](https://openreview.net/forum?id=WmIwYTd0YTF).
+ 1 million generated images of CIFAR-10 （cifar10-edm-1m.npz） from [EDM](https://arxiv.org/abs/2206.00364). 
+ 1/10 size of CIFAR-10 （cifar10-5k
-train.npz） for data-scarce scenarios in Section 5.1 in our paper.
+ 500k generated iamges of 1/10 size of CIFAR-10 (cifar10-5k-500k-stf.npz) from STF.

For more details of generating images, please refer to [README_gen.md](https://github.com/PKU-ML/adaInf/blob/master/README_gen.md).
 

## Pretrain SimCLR
Pretrain SimCLR with no inflation:
```
python3 ./solo-learn/main_pretrain.py --config-path ./solo-learn/scripts/pretrain/cifar/ --config-name simclr.yaml \
augmentations=symmetric.yaml \
wandb.project=AdaInf \
name=simclr_baseline \
max_steps=100000
```
Pretrain SimCLR with vanilla inflation:
```
python3 ./solo-learn/main_pretrain.py --config-path ./solo-learn/scripts/pretrain/cifar/ --config-name simclr.yaml \
augmentations=symmetric.yaml \
wandb.project=AdaInf \
name=simclr_vanilla \
data.extra_data=../datasets/generated/name.npz \
data.dup=1 \
max_steps=100000
```

Pretrain SimCLR with Adaptive Inflation（**AdaInf**）:
The hyper-parameter relevant to AdaInf is `augmentations`(augmentation strength), `data.extra_data` (path of generated images) and `data.dup` (replicating times of real data). When using AdaInf, select "symmetric_adainf.yaml" for SSL methods that utilize symmetric augmentation (e.g., SimCLR, Moco V2), and select "asymmetric_adainf.yaml" for SSL methods that utilize asymmetric augmentation (e.g., Barlow Twins, BYOL).
```
python3 ./solo-learn/main_pretrain.py --config-path ./solo-learn/scripts/pretrain/cifar/ --config-name simclr.yaml \
augmentations=symmetric_adainf.yaml \
wandb.project=AdaInf \
name=simclr_adainf \
data.extra_data=./datasets/generated/name.npz \
data.dup=10 \
max_steps=100000
```

For more scripts and more parameter configurations, please refer to [./scripts](https://github.com/PKU-ML/adaInf/tree/master/scripts) and [./solo-learn/scripts](https://github.com/PKU-ML/adaInf/tree/master/solo-learn/scripts).

## Results of CIFAR-10
| Inflation | SimCLR | MoCo V2 | BYOL| Barlow Twins| 
|--------|--------|--------|--------|--------|
| No | 91.56 | 92.75 |92.46 |91.24 |
| Vanilla | 91.38 | 92.51 |**92.9**|92.09|
|AdaInf|**93.42**|**94.19**|92.87|**93.64**|
## Citation

If you find the work useful, please cite the accompanying paper:
```
@inproceedings{
wang2024do,
title={Do Generated Data Always Help Contrastive Learning?},
author={Yifei Wang and Jizhe Zhang and Yisen Wang},
booktitle={ICLR},
year={2024}
}
```




