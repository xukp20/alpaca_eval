set -x
set -e

export IS_ALPACA_EVAL_2=False
export HF_HOME="/cephfs/shared/hf_cache"

REFERENCE_MODEL="gpt4_turbo"

# alpaca_eval evaluate_from_model SPPO-Llama-3-Instruct-8B-Iter1-custom --reference_outputs $REFERENCE_MODEL
# alpaca_eval evaluate_from_model Meta-Llama-3-8B-Instruct --reference_outputs $REFERENCE_MODEL
alpaca_eval evaluate_from_model Meta-Llama-3-8B-Instruct-custom --reference_outputs $REFERENCE_MODEL