ln -s apps/easy_code2.js .
ln -s apps/easy_tut2.js .
ln -s apps/easy_tut2x.js .
ln -s apps/story.html .
ln -s apps/xmas.html .
ln -s apps/easyw.wasm .
ln -s apps/easyw.js .
ln -s apps/tut_learn.html .
ln -s apps/tut_learnx.html .
ln -s apps/tut_game.html .
ln -s apps/tut_docu.html .
ln -s apps/tut_docu.html doc.html
ln -s apps/tut_func.html docfunc.html
ln -s apps/tut_mcarlo.html mcarlo.html
ln -s apps/letter-memory.html .
ln -s apps/easy.js .
ln -s tut_learn.html programming_basics.html
ln -s tut_learn.html learn_programming.html
ln -s apps/index.html .

# mkdir ide apps run games aoc sky
# for i in $(seq 15 25); do mkdir aoc/$i; done

# -------------------------

i=tut_docu.html
ln -fs $i apps/tutorial_documentation_and_code_snippets.html

i=tut_learn.html
ln -fs $i apps/tutorial_learn_programming.html
ln -fs $i apps/tutorial_learn.html
ln -fs $i apps/tutorial_beginner.html
ln -fs $i apps/tutorial_programming_basics.html
ln -fs $i apps/programming_basics.html

i=tut_game.html
ln -fs $i apps/tutorial_programming_a_letter_memory_game.html
ln -fs $i apps/tutorial_game_programming.html
ln -fs $i apps/tutorial_game.html
ln -fs $i apps/tutorial_games.html

i=tut_mcarlo.html
ln -fs $i apps/tutorial_monte_carlo_methods.html
ln -fs $i apps/tutorial_mcarlo.html
ln -fs $i apps/tutorial_monte_carlo.html

i=tut_sorting.html
ln -fs $i apps/tutorial_sorting_algorithms.html
ln -fs $i apps/tutorial_sorting.html

