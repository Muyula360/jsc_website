import React, { useState, useEffect } from "react";
import { Link, useNavigate } from 'react-router-dom';
import { useDispatch, useSelector } from "react-redux";

import { Line } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, LineElement, PointElement, Title, Tooltip, Legend, Filler } from 'chart.js';


import { getWeeklyVisitsTrends } from '../features/weeklyvisittrendSlice';

ChartJS.register(CategoryScale, LinearScale, LineElement, PointElement, Title, Tooltip, Legend, Filler);




const WeeklyVisitTrends = () => {

    const dispatch = useDispatch();

    const { weeklyVisitsTrends, isLoading, isSuccess, isError } = useSelector((state) => state.weeklyVisitsTrends);

    const [ chartData, setChartData ] = useState({ labels: [], datasets: [] });


    // when this component (weeklyVisitTrends) loads dispatch getWeeklyVisitsTrends (this function fetch WeeklyVisitsTrends from API)
    useEffect(() => {
    
    dispatch(getWeeklyVisitsTrends());
    
    }, [dispatch]);


    // set chart graph data 
    useEffect(() => {

        if (isSuccess && weeklyVisitsTrends.length > 0) {
        // Fill last 7 days even if some days have 0 visits
        const today = new Date();
        const labels = [];
        const data = [];

        for (let i = 6; i >= 0; i--) {
            const date = new Date(today);
            date.setDate(today.getDate() - i);
            const dateStr = date.toISOString().split('T')[0];
            labels.push(dateStr);

            const entry = weeklyVisitsTrends.find(v => v.visit_date === dateStr);
            data.push(entry ? parseInt(entry.total_visits) : 0);
        }

        setChartData({
            labels,
            datasets: [
            {
                label: "Visits",
                data,
                fill: true,
                backgroundColor: "rgba(236, 31, 47, 0.1)",
                borderColor: "#ec1f2f",                     
                pointBackgroundColor: "#ec1f2f",
                pointBorderColor: "#ec1f2f",
                pointHoverBackgroundColor: "#ffffff",
                pointHoverBorderColor: "#ec1f2f",
                tension: 0.4,
                pointRadius: 5,
                pointHoverRadius: 7,
            }
            ]
        });
        }

    }, [isSuccess, weeklyVisitsTrends]);


    // Chart UI
    return (

        <div className="card hover-border">
            <div className="card-body">

                <h5 className="card-title">
                <i className="bi bi-graph-up-arrow text-accent me-1"></i> Website Visits
                </h5>

                {isLoading ? (
                <p>Loading chart...</p>
                ) : isError ? (
                <p>Error loading data</p>
                ) : (
                <Line data={chartData} options={{ responsive: true, plugins: {legend: {position: 'top', }, title: { display: false, text: 'Website Visits - Last 7 Days', }, }, }} />
                )}
                
            </div>
        </div>
    );

}

export default WeeklyVisitTrends