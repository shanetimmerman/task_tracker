import css from "../css/app.scss";

import jQuery from 'jquery';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";


import "phoenix_html"

$(function () {

    $('#start-button').click((ev) => {
        let task_id = $(ev.target).data('task-id');

        let text = JSON.stringify({
            task: {
              start_time: new Date().getTime(),
            },
          });

        $.ajax(window.task_path + "/" + task_id, {
            method: "put",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: text,
            success: (resp) => {
                // $('#rating-form').text(`(your rating: $(rating))`);
                console.log(resp.data.start_time);
                console.log("success");
            },
        });
    });

    $('#stop-button').click((ev) => {
        let task_id = $(ev.target).data('task-id');

        $.ajax(window.task_path + "/" + task_id, {
            method: "get",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: "",
            success: (resp) => {
                let start_time = resp.data.start_time;
                new_time_block(start_time, task_id);
                reset_start_time(task_id);
            }});

        function new_time_block(start_time, task_id) {
            let text = JSON.stringify({
                task: {
                  start: start_time,
                  end: new Date().getTime(),
                  task_id: task_id,
            }});
            $.ajax(window.time_block_path, {
                method: "post",
                dataType: "json",
                contentType: "application/json; charset=UTF-8",
                data: text,
                success: (resp) => {
                    // $('#rating-form').text(`(your rating: $(rating))`);
                    console.log(resp.data.start_time);
                    console.log("success");
                },
            });
        }

        function reset_start_time(task_id) {
            $.ajax(window.task_path + "/" + task_id, {
                method: "put",
                dataType: "json",
                contentType: "application/json; charset=UTF-8",
                data: JSON.stringify({
                    start_time: null,
                }),
                success: (_) => {
                    // $('#rating-form').text(`(your rating: $(rating))`);
                    console.log("success");
                },
            });
        }

    });
});
