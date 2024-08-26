set -x
set -e

export IS_ALPACA_EVAL_2=True
export HF_HOME="/cephfs/shared/hf_cache"

# REFERENCE_MODEL="/cephfs/xukangping/code/alpaca_eval/results/gpt4_1106_preview/model_outputs.json"

# MODEL_NAME="SPPO-Llama-3-Instruct-8B-Iter1-custom"
# MODEL_NAME="Meta-Llama-3-8B-Instruct-custom"
MODEL_NAMES=(
    # "SPPO-Llama-3-Instruct-8B-Iter1-custom"
    # "Meta-Llama-3-8B-Instruct-custom"
    # "Meta-Llama-3-8B-Instruct"
    # "gpt4_1106_preview"
    "SPPO-Llama-3-Instruct-8B-Iter1-table-custom"
)

JUDGER=weighted_alpaca_eval_deepseek
# start from None leaderboards
LAST_TIME_FINAL_MODEL="gpt4_1106_preview"

LEADERBOARD="None"
if [ ! -z $LAST_TIME_FINAL_MODEL ]; then
    LEADERBOARD="results/$LAST_TIME_FINAL_MODEL/$JUDGER/leaderboard.csv"
fi

for MODEL_NAME in "${MODEL_NAMES[@]}"; do
    alpaca_eval evaluate_from_model $MODEL_NAME --annotators_config $JUDGER --precomputed_leaderboard $LEADERBOARD
    LEADERBOARD=results/$MODEL_NAME/$JUDGER/leaderboard.csv
done
