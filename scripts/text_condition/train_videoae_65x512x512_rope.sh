export WANDB_KEY=""
export ENTITY=""
export PROJECT="512_rope_abs"
accelerate launch \
    --config_file scripts/accelerate_configs/deepspeed_zero2_config.yaml \
    opensora/train/train_t2v.py \
    --model LatteT2V-XL/122 \
    --text_encoder_name DeepFloyd/t5-v1_1-xxl \
    --cache_dir "../../Open-Sora-Plan/cache_dir" \
    --dataset t2v \
    --ae CausalVAEModel_4x8x8 \
    --ae_path "../../Open-Sora-Plan/CausalVAEModel_4x8x8/" \
    --video_data_path "../../Open-Sora-Plan/sharegpt4v_path_cap_64x512x512_mixkit.json" \
    --video_folder /remote-home1/dataset/data_split_tt \
    --image_data_path "../../../dataset/image_114054.json" \
    --image_folder "../../../dataset/picture" \
    --sample_rate 1 \
    --num_frames 65 \
    --max_image_size 512 \
    --gradient_checkpointing \
    --attention_mode xformers \
    --train_batch_size=4 \
    --dataloader_num_workers 10 \
    --gradient_accumulation_steps=1 \
    --max_train_steps=1000000 \
    --learning_rate=2e-05 \
    --lr_scheduler="constant" \
    --lr_warmup_steps=0 \
    --mixed_precision="bf16" \
    --report_to="tensorboard" \
    --checkpointing_steps=200 \
    --output_dir="512_rope_abs" \
    --allow_tf32 \
    --pretrained 512_useimg/checkpoint-5500/model/diffusion_pytorch_model.safetensors \
    --use_deepspeed \
    --model_max_length 300 \
    --use_image_num 4 \
    --use_img_from_vid \
    --enable_tiling \
    --use_rope
