set -x
set -e

export IS_ALPACA_EVAL_2=True
export HF_HOME="/cephfs/shared/hf_cache"
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"

MODEL_NAMES=(
    # "SPPO-Llama-3-Instruct-8B-Iter1-custom"
    # "Meta-Llama-3-8B-Instruct-custom"
    # "Meta-Llama-3-8B-Instruct"
    # "gpt4_1106_preview"
    # "SPPO-Llama-3-Instruct-8B-Iter1-table-custom"
    # SPPO-Llama-3-Instruct-8B-PairRM
    # "SPPO-Llama-3-Instruct-8B-Iter2-custom"
    # "SPPO-Llama-3-Instruct-8B-Iter2-table-custom"
    # "SPPO-Llama-3-Instruct-8B-Iter3-custom"
    # "SPPO-Llama-3-Instruct-8B-Iter1-table-custom"
    # "SPPO-Llama-3-Instruct-8B-Iter2-table-custom"
    # "SPPO-Llama-3-Instruct-8B-Iter3-table-custom"
    # "SPPO-Llama-3-Instruct-8B-Iter1_RM8B-table-custom"
    # "SPPO-Llama-3-Instruct-8B-Iter2_RM8B-table-custom"
    # "SPPO-Llama-3-Instruct-8B-Iter3_RM8B-table-custom"
    # SPPO-Llama-3-Instruct-8B-Iter1-score-table-0.01
    SPPO-Llama-3-Instruct-8B-Iter1-score-table-0.001
)

JUDGER=weighted_alpaca_eval_deepseek
# start from None leaderboards
LAST_TIME_FINAL_MODEL="SPPO-Llama-3-Instruct-8B-Iter1-score-table-0.1"
IS_OVER_WRITE_LEADERBOARD=True

LEADERBOARD="None"
if [ ! -z $LAST_TIME_FINAL_MODEL ]; then
    LEADERBOARD="results/$LAST_TIME_FINAL_MODEL/$JUDGER/leaderboard.csv"
fi

for MODEL_NAME in "${MODEL_NAMES[@]}"; do
    alpaca_eval evaluate_from_model $MODEL_NAME --annotators_config $JUDGER --precomputed_leaderboard $LEADERBOARD --is_overwrite_leaderboard $IS_OVER_WRITE_LEADERBOARD
    LEADERBOARD=results/$MODEL_NAME/$JUDGER/leaderboard.csv
done
