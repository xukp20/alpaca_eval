base_model_name = "SPPO-Llama-3-Instruct-8B-Iter1_bt_2b"
target_model_pattern = "SPPO-Llama-3-Instruct-8B-Iter{i}_gp_8b"

ckpt_dir = "/cephfs/xukangping/code/SPPO/checkpoints"
ckpt_pattern = "Llama-3-8B-Instruct-SPPO-Iter{i}_gp_8b-table"

iters=[1,2,3]

"""
SPPO-Llama-3-Instruct-8B-Iter1_bt_2b:
  completions_kwargs:
    batch_size: 900
    # do_sample: true
    use_beam_search: false
    max_new_tokens: 4096
    model_kwargs:
      dtype: bfloat16
    model_name: /cephfs/xukangping/code/SPPO/checkpoints/Llama-3-8B-Instruct-SPPO-Iter1_bt_2b-table
    stop_token_ids:
    - 128001
    - 128009
    temperature: 0.9
    top_p: 1.0
  fn_completions: vllm_local_completions
  pretty_name: SPPO-Llama-3-Instruct-8B-Iter1_bt_2b
  prompt_template: SPPO-Llama-3-Instruct-8B-PairRM/prompt.txt
"""

import os, yaml

# laod yaml file: configs.yaml from base_model_name dir
base_yaml = os.path.join(base_model_name, "configs.yaml")
with open(base_yaml, "r") as f:
    base_config = yaml.load(f, Loader=yaml.FullLoader)
    print(base_config)

for i in iters:
    target_model_name = target_model_pattern.format(i=i)
    ckpt_name = ckpt_pattern.format(i=i)

    # create new dir
    os.makedirs(target_model_name, exist_ok=True)

    # new config
    new_config = base_config[base_model_name]
    new_config["completions_kwargs"]["model_name"] = os.path.join(ckpt_dir, ckpt_name)
    new_config["pretty_name"] = target_model_name
    new_config = {target_model_name: new_config}

    # save new config
    target_yaml = os.path.join(target_model_name, "configs.yaml")
    with open(target_yaml, "w") as f:
        yaml.dump(new_config, f)

    print(f"Saved {target_yaml}")

    