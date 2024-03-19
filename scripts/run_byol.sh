# Byol baseline
python3 ../solo-learn/main_pretrain.py --config-path ../solo-learn/scripts/pretrain/cifar/ --config-name byol.yaml \
augmentations=asymmetric.yaml \
wandb.project=AdaInf \
name=byol_baseline \
max_steps=100000

# Byol Vanilla 
python3 ../solo-learn/main_pretrain.py --config-path ../solo-learn/scripts/pretrain/cifar/ --config-name byol.yaml \
augmentations=asymmetric.yaml \
wandb.project=AdaInf \
name=byol_vanilla \
data.extra_data=../datasets/generated/name.npz \
data.dup=1 \
max_steps=100000

# Byol   AdaInf 
python3 ../solo-learn/main_pretrain.py --config-path ../solo-learn/scripts/pretrain/cifar/ --config-name byol.yaml \
augmentations=asymmetric_adainf.yaml \
wandb.project=AdaInf \
name=byol_adainf \
data.extra_data=../datasets/generated/name.npz \
data.dup=10 \
max_steps=100000