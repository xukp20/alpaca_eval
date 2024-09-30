set -x
set -e

export IS_ALPACA_EVAL_2=True
export HF_HOME="/cephfs/shared/hf_cache"
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"

MODEL_NAMES=(
    SPPO-Llama-3-Instruct-8B-Iter1_gp_2b
    SPPO-Llama-3-Instruct-8B-Iter2_gp_2b
    SPPO-Llama-3-Instruct-8B-Iter3_gp_2b

    SPPO-Llama-3-Instruct-8B-Iter1-score_gp_2b-0.001
    SPPO-Llama-3-Instruct-8B-Iter2-score_gp_2b-0.001
    SPPO-Llama-3-Instruct-8B-Iter3-score_gp_2b-0.001

    SPPO-Llama-3-Instruct-8B-Iter1_bt_2b
    SPPO-Llama-3-Instruct-8B-Iter2_bt_2b
    SPPO-Llama-3-Instruct-8B-Iter3_bt_2b

    SPPO-Llama-3-Instruct-8B-Iter1-score_bt_2b-0.001
    SPPO-Llama-3-Instruct-8B-Iter2-score_bt_2b-0.001
    SPPO-Llama-3-Instruct-8B-Iter3-score_bt_2b-0.001

    SPPO-Llama-3-Instruct-8B-Iter1_gp_8b
    SPPO-Llama-3-Instruct-8B-Iter2_gp_8b
    SPPO-Llama-3-Instruct-8B-Iter3_gp_8b

    SPPO-Llama-3-Instruct-8B-Iter1-score_gp_8b-0.002
    SPPO-Llama-3-Instruct-8B-Iter2-score_gp_8b-0.002
    SPPO-Llama-3-Instruct-8B-Iter3-score_gp_8b-0.002

    SPPO-Llama-3-Instruct-8B-Iter1_bt_8b
    SPPO-Llama-3-Instruct-8B-Iter2_bt_8b
    SPPO-Llama-3-Instruct-8B-Iter3_bt_8b

    SPPO-Llama-3-Instruct-8B-Iter1-score_bt_8b-0.002
    SPPO-Llama-3-Instruct-8B-Iter2-score_bt_8b-0.002
    SPPO-Llama-3-Instruct-8B-Iter3-score_bt_8b-0.002
)

JUDGER=gpt4_turbo
# JUDGER=weighted_alpaca_eval_gpt-4o-mini
# start from None leaderboards
# LAST_TIME_FINAL_MODEL="SPPO-Llama-3-Instruct-8B-Iter3_gp_8b_tau01"
IS_OVER_WRITE_LEADERBOARD=True

LEADERBOARD="None"
if [ ! -z $LAST_TIME_FINAL_MODEL ]; then
    LEADERBOARD="results/$LAST_TIME_FINAL_MODEL/$JUDGER/leaderboard.csv"
fi

for MODEL_NAME in "${MODEL_NAMES[@]}"; do
    alpaca_eval evaluate_from_model $MODEL_NAME --annotators_config $JUDGER --precomputed_leaderboard $LEADERBOARD --is_overwrite_leaderboard $IS_OVER_WRITE_LEADERBOARD
    LEADERBOARD=results/$MODEL_NAME/$JUDGER/leaderboard.csv
done
