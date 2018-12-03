function getUserAnswers()
    local questions = {
        {
            text = "What is the domain name?",
        },
        --[[{
            text = "Set to default settings?",
            answers = {
                "yes",
                "no"
            }
        },
        {
            text = "Are you sure?",
            answers = {
                "yes",
                "no"
            }
        }]]--
    }
    local answers = {};
    local question_count = 0
    while(true)do
        question_count = question_count + 1
        if(question_count > #questions)then
            break
        end

        --fetches the answer
        local real_answer = nil;
        while(true)do
            print(questions[question_count].text)
            local a = io.read()
            if(questions[question_count].answers)then
                for k, v in pairs(questions[question_count].answers)do
                    if(v == a)then
                        real_answer = a
                        break
                    end
                end
            else
                real_answer = a
                break
            end
            if(real_answer)then
                break
            else
                print("Error: invalid answer. Please try again.")
            end
        end

        table.insert(answers, real_answer)
    end

    return answers
end