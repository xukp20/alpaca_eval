set -x
set -e

export IS_ALPACA_EVAL_2=True
export HF_HOME="/cephfs/shared/hf_cache"
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"

MODEL_1_NAME="SPPO-Llama-3-Instruct-8B-Iter2-custom"
MODEL_2_NAME="SPPO-Llama-3-Instruct-8B-PairRM"

JUDGER=weighted_alpaca_eval_deepseek


alpaca_eval evaluate_from_model $MODEL_1_NAME --reference_model_configs $MODEL_2_NAME --annotators_config $JUDGER --precomputed_leaderboard None

