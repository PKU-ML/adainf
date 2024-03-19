# SimCLR baseline
python3 ../solo-learn/main_pretrain.py --config-path ../solo-learn/scripts/pretrain/cifar/ --config-name simclr.yaml \
augmentations=symmetric.yaml \
wandb.project=AdaInf \
name=simclr_baseline \
max_steps=100000

# SimCLR Vanilla 
python3 ../solo-learn/main_pretrain.py --config-path ../solo-learn/scripts/pretrain/cifar/ --config-name simclr.yaml \
augmentations=symmetric.yaml \
wandb.project=AdaInf \
name=simclr_vanilla \
data.extra_data=../datasets/generated/name.npz \
data.dup=1 \
max_steps=100000

# SimCLR AdaInf 
python3 ../solo-learn/main_pretrain.py --config-path ../solo-learn/scripts/pretrain/cifar/ --config-name simclr.yaml \
augmentations=symmetric_adainf.yaml \
wandb.project=AdaInf \
name=simclr_adainf \
data.extra_data=../datasets/generated/name.npz \
data.dup=10 \
max_steps=100000